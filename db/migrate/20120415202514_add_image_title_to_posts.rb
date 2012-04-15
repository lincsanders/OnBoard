class AddImageTitleToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :image_title, :string
  end
end
