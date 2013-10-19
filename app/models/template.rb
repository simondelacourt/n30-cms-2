class Template < ActiveRecord::Base
  attr_accessible :title, :tdefault, :template, :stylesheet_ids, :javascript_ids, :head_title, :meta_keywords, :meta_description
  
  has_many :template_scripts, :dependent => :destroy #, :order => "template_scripts.ordernum"
  has_many :template_sheets, :dependent => :destroy #, :order => "template_sheets.ordernum"
  has_many :javascripts,  :through => :template_scripts#, :order => "template_scripts.ordernum",
  has_many :stylesheets, :through => :template_sheets#:order => "template_sheets.ordernum", 
  
  #scope :sorted, -> { order(:name) }
  
  def setdefaulttemplate
    self.class.where('id != ?', self.id).update_all("tdefault = '0'")
  end
  def to_param
    "#{id}-#{title.parameterize}"
  end
end
