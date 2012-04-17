class AddPostsApproved < ActiveRecord::Migration
  def change
  	add_column :posts, :approved, :boolean, :default => true
  end
end
