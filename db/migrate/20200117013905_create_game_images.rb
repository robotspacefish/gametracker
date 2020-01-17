class CreateGameImages < ActiveRecord::Migration[6.0]
  def change
    create_table :game_images do |t|
      t.string :height
      t.string :width
      t.integer :image_id
      t.string :url
      t.string :image_type
      t.integer :game_id
    end
  end
end
