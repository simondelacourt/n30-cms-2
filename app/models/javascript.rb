class Javascript < ActiveRecord::Base
  attr_accessible :title, :script, :external_link
  has_many :template_scripts
  
  def savetofile
    compressor = YUI::JavaScriptCompressor.new
    
    Dir.mkdir(Rails.root.join('public/as')) unless File.exists?(Rails.root.join('public/as'))
    
    Dir.mkdir(Rails.root.join('public/as/javascripts')) unless File.exists?(Rails.root.join('public/as/javascripts'))
      
    
    css_path = Rails.root.join('public/as/javascripts',"#{self.id}_#{self.title.parameterize}.js")
    File.open(css_path,"w+") do |f|
      f.write(compressor.compress(self.script))
    end
  end
  
  def getfileurl
    return "as/javascripts/#{self.id}_#{self.title.parameterize}.js"
  end
  
  
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  
end
