class Stylesheet < ActiveRecord::Base
  attr_accessible :title, :css, :external_link
  
  has_many :template_sheets
  
  def to_param
    "#{id}-#{title.parameterize}"
  end
  
end
