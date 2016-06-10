class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :currency, null: false
      t.integer :balance, limit: 8, null: false, default: 0
      t.belongs_to :wallet, null: false

      t.timestamps null: false
    end
  end
end
