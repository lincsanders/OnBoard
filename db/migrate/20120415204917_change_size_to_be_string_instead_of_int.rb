class ChangeSizeToBeStringInsteadOfInt < ActiveRecord::Migration
  def change
  	change_column(:posts, :size, :string)
  	change_column(:posts, :uploaded_by, :string)
  end
end
