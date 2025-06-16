class CreateRules < ActiveRecord::Migration[7.1]
  def change
    create_table :rules do |t|
      t.string :type, null: false
      t.string :product_code, null: false
      t.integer :threshold
      t.decimal :new_price, precision: 8, scale: 2
      t.decimal :percent, precision: 5, scale: 2

      t.timestamps
    end

    add_index :rules, :product_code
    add_index :rules, :type
  end
end
