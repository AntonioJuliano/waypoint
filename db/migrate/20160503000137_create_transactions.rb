class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :fee, limit: 8, null: false

      t.timestamps null: false
    end
  end
end
