class AddDraftTokenToWritings < ActiveRecord::Migration[5.0]
  def change
    add_column :writings, :draft_token, :string
  end
end
