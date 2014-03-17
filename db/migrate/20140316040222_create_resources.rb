class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :text
      t.string :value
      t.string :color
      t.references :resource_type, index: true
      t.timestamps
    end
  end
end
