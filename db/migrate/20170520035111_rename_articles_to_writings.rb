class RenameArticlesToWritings < ActiveRecord::Migration[5.0]
  def change
    rename_table :articles, :writings
  end
end
