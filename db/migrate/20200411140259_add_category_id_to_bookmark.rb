class AddCategoryIdToBookmark < ActiveRecord::Migration[6.0]
  def change
    add_column :bookmarks, :category_id, :integer
  end
end
