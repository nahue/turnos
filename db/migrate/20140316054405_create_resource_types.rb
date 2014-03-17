class CreateResourceTypes < ActiveRecord::Migration
  def change
    create_table :resource_types do |t|
      t.string :title
      t.boolean :multiple
      t.string :field
      t.timestamps
    end
  end
end
