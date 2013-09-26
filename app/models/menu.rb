class Menu < ActiveRecord::Base
  attr_accessible :linkid, :linkmode, :order, :title, :externalink, :parent_id
  
  has_ancestry :orphan_strategy => :destroy
  
  validates :title, presence: true
end
