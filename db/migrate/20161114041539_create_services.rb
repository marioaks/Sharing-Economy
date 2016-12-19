class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.text :website
      t.text :description
      t.integer :founded
      t.string :topic
      t.timestamps null: false
    end
  end
end
