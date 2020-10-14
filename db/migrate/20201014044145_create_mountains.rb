class CreateMountains < ActiveRecord::Migration[6.0]
  def change
    create_table :mountains do |t|
      t.string :name, null: false
      t.string :area, null: false
      t.string :prefecture, null: false
      t.integer :height, null: false
      t.text :feature

      t.timestamps
    end
  end
end
