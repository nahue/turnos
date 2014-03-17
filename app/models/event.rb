class Event < ActiveRecord::Base
  attr_accessible :title, :start, :end, :startTimezone, :endTimezone, :description, :recurrenceId, :recurrenceRule, :recurrenceException, :isAllDay
  has_and_belongs_to_many :resources
end
