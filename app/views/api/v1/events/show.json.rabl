object @event
attributes :id, :title, :start, :end, :startTimezone, :endTimezone, :description, :recurrenceId, :recurrenceRule, :recurrenceException, :isAllDay

ResourceType.all.each do |rt|
  node(rt.getName) { |event| rt.getResourceIds event }
end
