class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.decimal :balance
      t.string :stock

      t.timestamps
    end
  end
end
