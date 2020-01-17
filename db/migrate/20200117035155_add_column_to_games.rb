class AddColumnToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :igdb_id, :integer
  end
end
