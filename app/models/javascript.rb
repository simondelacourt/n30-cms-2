class Javascript < ActiveRecord::Base
  attr_accessible :title, :script, :external_link
  has_many :template_scripts
  
  def savetofile
    Dir.mkdir('app/assets/javascripts/int') unless File.exists?('app/assets/javascripts/int')
    
    
    css_path = Rails.root.join('app/assets/javascripts/int',"#{self.id}_#{self.title.parameterize}.js")
    File.open(css_path,"w+") do |f|
      f.write(self.script)
    end
  end
  
  def getfileurl
    return "int/#{self.id}_#{self.title.parameterize}.js"
  end
  
  
  extend FriendlyId
  friendly_id :title, use: :slugged
  
end
