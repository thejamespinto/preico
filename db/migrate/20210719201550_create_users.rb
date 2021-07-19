class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_hash
      t.string :session_token
      t.string :reset_token
      t.string :role

      t.timestamps
    end
  end
end
