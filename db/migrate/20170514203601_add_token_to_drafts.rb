class AddTokenToDrafts < ActiveRecord::Migration[5.0]
  def change
    add_column :drafts, :token, :string
    add_index :drafts, :token, unique: true
  end
end
