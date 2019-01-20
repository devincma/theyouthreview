class RenameTagLine < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :tag_line, :about_me
  end
end
