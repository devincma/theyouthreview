class AddIsTrustedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_trusted, :boolean, default: false
  end
end
