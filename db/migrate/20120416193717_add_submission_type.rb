class AddSubmissionType < ActiveRecord::Migration
  def change
    add_column :posts, :submission_type, :string
  end
end
