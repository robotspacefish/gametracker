class AddCustomColumnToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :custom, :boolean
  end
end
