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
end
