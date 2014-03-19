class Event < ActiveRecord::Base
  attr_accessible :title, :start, :end, :startTimezone, :endTimezone, :description, :recurrenceId, :recurrenceRule, :recurrenceException, :isAllDay
  has_and_belongs_to_many :resources

  def assign_resources(event_params)
    types = ResourceType.all.map {|m| m.multiple? ? m.title : m.field}
    types.each do |type|

      resources = self.resources.includes(:resource_type).where("resource_types.title == ? OR resource_types.field == ? ", type, type)
      resource_ids = resources.map {|r| r.id}
      ids = (event_params[type].is_a? Array) ? event_params[type].map {|a| a.to_i} : event_params[type].to_i


      # checks if related resources matches resources given by POST request
      if !resource_ids.empty? && (resource_ids != ids)
        self.resources.destroy resources
      end


      # if given resources are the same... don't do anything
      unless resource_ids == ids
        unless ids == 0
          if ids.is_a? Integer
            self.resources << Resource.find(ids)
          else
            ids.each do |id|
              self.resources << Resource.find(id)
            end
          end
        end
      end

    end
  end
end
