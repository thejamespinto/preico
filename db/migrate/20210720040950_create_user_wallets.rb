class CreateUserWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :user_wallets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :key
      t.integer :amount, default: 0

      t.timestamps
    end

    create_table :user_wallet_entries do |t|
      t.references :user_wallet, null: false, foreign_key: true
      t.integer :amount, default: 0

      t.timestamps
    end
  end
end
