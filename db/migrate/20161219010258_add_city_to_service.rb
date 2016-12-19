class AddCityToService < ActiveRecord::Migration
  def change
    add_reference :services, :city, index: true, foreign_key: true
  end
end
