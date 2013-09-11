class Template < ActiveRecord::Base
  attr_accessible :title, :default, :template, :stylesheet_ids, :javascript_ids, :head_title, :meta_keywords, :meta_description
  
  has_many :template_scripts, :dependent => :destroy
  has_many :template_sheets, :dependent => :destroy
  has_many :javascripts, :through => :template_scripts
  has_many :stylesheets, :through => :template_sheets
end
