class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :forename
      t.string :surname
      t.string :twitter_username

      t.timestamps
    end
  end
end
