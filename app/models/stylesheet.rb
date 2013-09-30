class Stylesheet < ActiveRecord::Base
  attr_accessible :title, :css, :external_link
  
  has_many :template_sheets
  
  def savetofile
    compressor = YUI::CssCompressor.new
    
    Dir.mkdir(Rails.root.join('public/as')) unless File.exists?(Rails.root.join('public/as'))
    
    Dir.mkdir(Rails.root.join('public/as/stylesheets')) unless File.exists?(Rails.root.join('public/as/stylesheets'))
    
    css_path = Rails.root.join('public/as/stylesheets',"#{self.id}_#{self.title.parameterize}.css")
    File.open(css_path,"w+") do |f|
      f.write(compressor.compress(self.css))
    end
  end
  
  def getfileurl
    return "as/stylesheets/#{self.id}_#{self.title.parameterize}.css"
  end
  
  extend FriendlyId
  friendly_id :title, use: :slugged
end
