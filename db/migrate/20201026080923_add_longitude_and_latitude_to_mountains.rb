class AddLongitudeAndLatitudeToMountains < ActiveRecord::Migration[6.0]
  def change
    add_column :mountains, :longitude, :float
    add_column :mountains, :latitude, :float
  end
end
