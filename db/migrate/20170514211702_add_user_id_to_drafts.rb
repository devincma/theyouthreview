class AddUserIdToDrafts < ActiveRecord::Migration[5.0]
  def change
    add_reference :drafts, :user, foreign_key: true
  end
end
