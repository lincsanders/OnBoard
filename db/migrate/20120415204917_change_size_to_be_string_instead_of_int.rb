class ChangeSizeToBeStringInsteadOfInt < ActiveRecord::Migration
  def change
  	change_column(:posts, :size, :string)
  end
end
