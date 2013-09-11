class TemplateSheet < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :template
  belongs_to :stylesheet
end
