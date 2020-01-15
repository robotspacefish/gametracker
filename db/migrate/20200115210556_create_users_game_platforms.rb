class CreateUsersGamePlatforms < ActiveRecord::Migration[6.0]
  def change
    create_table :users_game_platforms do |t|
      t.integer :user_id
      t.integer :game_platform_id
    end
  end
end
