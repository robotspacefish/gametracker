class CreateGames < ActiveRecord::Migration[6.0]
   def change
    create_table :games do |t|
      t.string :title
      t.string :url
      t.string :summary
    end
  end
end
