class Page < ActiveRecord::Base
  attr_accessible :body, :parent_id, :title, :sourcefromchildren, :page_plugin_id, :showamountembed
  has_many :embeddables, dependent: :destroy
  belongs_to :page_plugin
  
  has_ancestry


  extend FriendlyId
  friendly_id :title, use: :slugged

end
