class AddRIdToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :uniq_key, :string
  end
end
