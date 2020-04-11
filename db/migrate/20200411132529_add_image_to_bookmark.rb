class AddImageToBookmark < ActiveRecord::Migration[6.0]
  def change
    add_column :bookmarks, :image, :string
  end
end
