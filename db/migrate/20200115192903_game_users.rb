class GameUsers < ActiveRecord::Migration[6.0]
  create_table :game_users do |t|
    t.integer :user_id
    t.integer :game_id
  end
end
