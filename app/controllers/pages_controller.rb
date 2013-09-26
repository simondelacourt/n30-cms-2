class PagesController < ApplicationController
  def show
    @page = Page.find(params[:id])
    @ids = [params[:id].to_i]
    if @page.sourcefromchildren
      @page.descendants.each do |d|
        @ids.push d.id
      end
      @embeddables = Embeddable.where(page_id: @ids)
    else
      @embeddables = Embeddable.where(page_id: params[:id])
    end
    
    begin
      render :inline => @page.galleryplugin.erb, :layout => true, :locals => {:page => @page, :embeddables => @embeddables}
    rescue ActionView::Template::Error => e
      render :inline => "template error + #{e}", :layout => true
      
    end
    
  end
end
