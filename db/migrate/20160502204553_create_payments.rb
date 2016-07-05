class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :type, null: false
      t.string :currency, null: false
      t.string :state, null: false, index: true
      t.integer :amount, limit: 8, null: false
      t.boolean :external, null: false, default: false
      t.belongs_to :transaction, index: true, null: false
      t.belongs_to :account, index: true

      t.timestamps null: false
    end
  end
end
