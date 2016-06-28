class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :contact
      t.string :location
      t.string :verified
      t.string :photos
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
