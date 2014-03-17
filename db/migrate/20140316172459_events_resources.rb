class EventsResources < ActiveRecord::Migration
  def change
    create_table :events_resources do |t|
      t.belongs_to :event
      t.belongs_to :resource
    end
  end
end
