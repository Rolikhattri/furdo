class CreateInstallments < ActiveRecord::Migration
  def change
    create_table :installments do |t|
      t.date :due_date
      t.date :payment_date
      t.string :status
      t.float :amount
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
