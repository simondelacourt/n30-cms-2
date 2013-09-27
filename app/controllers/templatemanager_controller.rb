class TemplatemanagerController < ApplicationController
  def css
    @css = Stylesheet.find(params[:id])
    respond_to do |format|
      format.css {}
    end
  end
  def js
    @js = Javascript.find(params[:id])
    respond_to do |format|
      format.js {}
    end
  end
  
  def plugin
    @plugin = PagePlugin.find(params[:id])
    @page = Page.find(params[:page])
    @ids = [params[:page].to_i]
    if @page.sourcefromchildren
      @page.descendants.each do |d|
        @ids.push d.id
      end
      @embeddables = Embeddable.where(page_id: @ids)
    else
      @embeddables = Embeddable.where(page_id: params[:id])
    end
    
    respond_to do |format|
    
      if params[:format] == 'js'
        format.js {render :text => @plugin.js, :locals => {:page => @page, :embeddables => @embeddables}}
      else
        format.css {render :text => @plugin.css, :locals => {:page => @page, :embeddables => @embeddables}}
      end
    end
  end
end
