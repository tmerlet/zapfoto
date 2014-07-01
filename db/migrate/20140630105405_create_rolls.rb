class CreateRolls < ActiveRecord::Migration
  def change
    create_table :rolls do |t|
      t.string :name
      t.string :state, default: "filling", null: false
      t.boolean :current, default: true, null: false
      t.integer :size, default: 25, null: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
