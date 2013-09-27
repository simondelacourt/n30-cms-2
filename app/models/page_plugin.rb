class PagePlugin < ActiveRecord::Base
  attr_accessible :title, :erb, :css, :js

end
