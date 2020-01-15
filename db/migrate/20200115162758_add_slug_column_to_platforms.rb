class AddSlugColumnToPlatforms < ActiveRecord::Migration[6.0]
  def change
    add_column :platforms, :slug, :string
  end
end
