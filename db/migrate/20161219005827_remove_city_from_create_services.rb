class RemoveCityFromCreateServices < ActiveRecord::Migration
  def change
    remove_column :services, :city, :string
  end
end
