class ResourceType < ActiveRecord::Base
  attr_accessible :title, :multiple, :field
  has_many :resources, :dependent => :delete_all

  validates :title, presence: true
  validates :title, format: { with: /\A[a-zA-Z0-9_]+\Z/ }
  validates :title, uniqueness: true
  validates :field, presence: true
  validates :field, format: { with: /\A[a-zA-Z0-9_]+\Z/ }
  validates :field, uniqueness: true
  paginates_per 10

  # get name for json response
  def getName
    a = 0
    self.resources.map {|r|
      unless r.event_ids.empty?
        a += 1
      end
    }
    if a > 0
      return self.multiple? ? self.title : self.field
    end
    nil
  end

  # returns array or single integer of id(s) of a given event
  def getResourceIds(event)

    # get ids of resources of the given element that belongs to this resource_type
    ids = event.resources.map {|r| (r.resource_type == self) ? r.id : nil} - [nil]

    unless ids.empty?
      return self.multiple? ? ids : ids.first
    end
    nil
  end

end
