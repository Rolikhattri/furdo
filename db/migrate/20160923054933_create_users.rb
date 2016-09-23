class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :total_amount
      t.boolean :discount
      t.integer :percentage
      t.integer :emi_option

      t.timestamps null: false
    end
  end
end
