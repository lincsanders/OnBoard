class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :unique_id
      t.string :mime_type
      t.integer :size
      t.integer :uploaded_by

      t.timestamps
    end
  end
end
