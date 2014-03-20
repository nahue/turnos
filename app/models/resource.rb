class Resource < ActiveRecord::Base
  attr_accessible :text, :value, :color, :resource_type_id
  belongs_to :resource_type
  has_and_belongs_to_many :events

  paginates_per 10
end
