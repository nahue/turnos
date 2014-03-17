class ResourceType < ActiveRecord::Base
  attr_accessible :title, :multiple, :field

  # get name for json response
  def getName
    self.multiple? ? self.title : self.field
  end

  # returns array or single integer of id(s) of a given event
  def getResourceIds(event)
    ids = event.resource_ids
    self.multiple? ? ids : ids.first
  end
end
