class Embeddable < ActiveRecord::Base
  attr_accessible :title, :body, :htmlbody, :linkmode, :description
  belongs_to :page
  
  validates :title, presence: true
end
