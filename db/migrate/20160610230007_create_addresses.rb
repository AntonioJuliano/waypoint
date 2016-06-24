class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :currency, null: false, index: true
      t.string :address, null: false, index: true
      t.string :encrypted_private_key, null: false
      t.belongs_to :account, index: true

      t.timestamps null: false
    end
  end
end
