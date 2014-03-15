class Event < ActiveRecord::Base
  attr_accessible :title, :start, :end, :startTimezone, :endTimezone, :description, :recurrenceId, :recurrenceRule, :recurrenceException, :isAllDay
end
