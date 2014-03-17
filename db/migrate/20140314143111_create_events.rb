class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.timestamp :start
      t.timestamp :end
      t.string :startTimezone
      t.string :endTimezone
      t.string :description
      t.integer :recurrenceId
      t.string :recurrenceRule
      t.string :recurrenceException
      t.boolean :isAllDay
      t.references :resource, index: true
      t.timestamps
    end
  end
end
