class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :file_name
      t.string :unique_id
      t.string :mime_type
      t.integer :rating
      t.integer :size
      t.integer :uploaded_by
      t.string :uploaded_by_name

      t.timestamps
    end
  end
end
