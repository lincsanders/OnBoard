class CreateModerators < ActiveRecord::Migration
  def change
    create_table :moderators do |t|
      t.string :username
      t.string :password
      t.datetime :login_time

      t.timestamps
    end
  end
end
