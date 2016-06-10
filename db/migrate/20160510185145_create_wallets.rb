class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
