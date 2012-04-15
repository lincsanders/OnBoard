class ChangeUploadedByToString < ActiveRecord::Migration
  def up
  	change_column(:posts, :uploaded_by, :string)
  end

  def down
  	change_column(:posts, :uploaded_by, :integer)
  end
end
