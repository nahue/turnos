class ResourceType < ActiveRecord::Base
  attr_accessible :title, :multiple, :field
  has_many :resources, :dependent => :delete_all
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
