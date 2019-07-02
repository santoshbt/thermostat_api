class CreateReadings < ActiveRecord::Migration[5.2]
  def change
    create_table :readings do |t|
      t.references :thermostat, index: true, null: false
      t.integer :tracking_number
      t.float :temperature, null: false
      t.float :humidity, null: false
      t.float :battery_recharge, null: false
      t.timestamps
    end
  end
end
