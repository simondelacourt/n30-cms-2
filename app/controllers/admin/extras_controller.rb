class Admin::ExtrasController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    @pagetitle = 'Extras'
    @bloggroup = BlogGroup.all
    
  end
  
  def importtumblr
    # old fashioned tumblr import
    # we import it allllll http://
    
    if params[:extras][:url][0..7] == 'http://'
      url = params[:extras][:url] + "/api/read?num=50"
    else
      url = "http://" + params[:extras][:url] + "/api/read?num=50"
    end
    
    resp = Net::HTTP.get_response(URI.parse(url)) # we will do 50 posts per import
    data = resp.body
    tumblr_xml = Nokogiri::XML(data)
    postamount = tumblr_xml.xpath("//posts").xpath("@total").text.to_f
    postamountnow = tumblr_xml.xpath("//posts").xpath("@start").text
    
    # fetch the selected post category
    @postcategory = BlogCategory.find(params[:extras][:blog_category_id])
    if @postcategory.nil?
      @postcategory = BlogCategory.first
    end
    
    # count the amount of imports we need to do
    importstodo = (postamount / 50).ceil
    countimports = importstodo
    postextra = 0
    do_import tumblr_xml
    
    importstodo.times do
      countimports -= 1
      if countimports == 0
        # re use the first request, a lot faster
        do_import tumblr_xml
      else
        # new requests, we need to check the url
        if params[:extras][:url][0..7] == 'http://'
          url = params[:extras][:url] + "/api/read?num=50&start=#{countimports*50}"
        else
          url = "http://" + params[:extras][:url] + "/api/read?num=50&start=#{countimports*50}"
        end
        #make the request
        resp = Net::HTTP.get_response(URI.parse(url)) # we will do 50 posts per import
        data = resp.body
        tumblr_xml_d = Nokogiri::XML(data)
        # import the data for these requests
        do_import tumblr_xml_d
      end
    end    
  end
  
  private
  def do_import data
    data.xpath("//post").each do |t|
      newpost = BlogPost.new
  
      newpost.title = t.xpath("regular-title").text
      newpost.original_id = t.xpath("@id").text
      newpost.created_at = Time.at(t.xpath("@unix-timestamp").text.to_i)
      newpost.user = current_user
      newpost.blog_category = @postcategory
      newpost.status = 'published'
      page = Nokogiri::HTML(t.xpath("regular-body").text.gsub(/\n/,""))
      howfar = 0
      body = ''
      whereto = 0
      page.css('body').children.each do |p|
        if p.text.empty?
          whereto += 1
        end
        if howfar == whereto && !p.text.empty?
          newpost.intro = ActionController::Base.helpers.sanitize(p.to_s, tags: %w(a))
        else
          body = body + p.to_s
        end
        howfar += 1
      end
      newpost.body = body
      newpost.save
    end
  end
end
