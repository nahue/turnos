class Resource < ActiveRecord::Base
  attr_accessible :text, :value, :color, :resource_type_id
  belongs_to :resource_type
  has_and_belongs_to_many :events

  validates :text, presence: true
  validates :color, presence: true

  paginates_per 10
end
