class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.string :name
      t.text :body

      t.timestamps
    end
  end
end
