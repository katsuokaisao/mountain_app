class CreateDailies < ActiveRecord::Migration[6.0]
  def change
    create_table :dailies do |t|
      t.string :mountain-name
      t.string :title
      t.text :comment
      t.references :user, null: false, foreign_key: true
      t.references :mountain, null: false, foreign_key: true

      t.timestamps
    end
  end
end
