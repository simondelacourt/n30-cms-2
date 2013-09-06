class Menu < ActiveRecord::Base
  attr_accessible :linkid, :linkmode, :order, :title, :externalink, :parent_id
  
  has_ancestry
  
end
