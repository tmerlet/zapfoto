class CreateRolls < ActiveRecord::Migration
  def change
    create_table :rolls do |t|
      t.string :name
      t.string :state
      t.boolean :current
      t.integer :size
      t.references :user, index: true

      t.timestamps
    end
  end
end
