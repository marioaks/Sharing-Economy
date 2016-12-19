class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.integer :world110_id

      t.timestamps null: false
    end
  end
end
