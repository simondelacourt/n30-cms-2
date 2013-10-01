class Admin::ExtrasController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    
  end
  
  def importtumblr
    resp = Net::HTTP.get_response(URI.parse(params[:extras][:url]))
    data = resp.body
    tumblr_xml = Nokogiri::XML(data)
    postamount = tumblr_xml.xpath("//posts").xpath("@total").text
    
    postextra = 0
    
    postcategory = BlogCategory.first
    
    tumblr_xml.xpath("//post").each do |t|
      newpost = BlogPost.new
      newpost.body = t.xpath("regular-body").text
      
      newpost.title = t.xpath("regular-title").text
      newpost.original_id = t.xpath("@id").text
      newpost.created_at = Time.at(t.xpath("@unix-timestamp").text.to_i)
      newpost.user = current_user
      newpost.blog_category = postcategory
      
      page = Nokogiri::HTML(t.xpath("regular-body").text)
      if page.css("p").css("strong").count > 0
        newpost.intro = page.css("p").css("strong")[0].text
      elsif page.css("p").css("b").count > 0
        newpost.intro = page.css("p").css("b")[0].text
      else
        newpost.intro = ''
        
      end
      
      if newpost.save
        postextra = postextra + 1
      end
      
    end
    
  end
end
