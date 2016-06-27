class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :state, null: false, index: true
      t.belongs_to :wallet, index: true

      t.timestamps null: false
    end
  end
end
