class Stylesheet < ActiveRecord::Base
  attr_accessible :title, :css, :external_link
  
  has_many :template_sheets
  
  def savetofile
    compressor = YUI::CssCompressor.new
    
    Dir.mkdir('app/assets/stylesheets/int') unless File.exists?('app/assets/stylesheets/int')
    
    css_path = Rails.root.join('app/assets/stylesheets/int',"#{self.id}_#{self.title.parameterize}.css")
    File.open(css_path,"w+") do |f|
      f.write(compressor.compress(self.css))
    end
  end
  
  def getfileurl
    return "int/#{self.id}_#{self.title.parameterize}.css"
  end
  
  extend FriendlyId
  friendly_id :title, use: :slugged
end
