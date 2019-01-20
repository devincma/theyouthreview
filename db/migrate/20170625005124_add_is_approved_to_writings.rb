class AddIsApprovedToWritings < ActiveRecord::Migration[5.0]
  def change
    add_column :writings, :is_approved, :boolean, default: false
  end
end
