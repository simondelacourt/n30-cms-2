class Page < ActiveRecord::Base
  attr_accessible :body, :parent_id, :title, :sourcefromchildren
  has_many :embeddables, dependent: :destroy
  
  has_ancestry

end
