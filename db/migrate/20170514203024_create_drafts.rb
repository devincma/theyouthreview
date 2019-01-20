class CreateDrafts < ActiveRecord::Migration[5.0]
  def change
    create_table :drafts do |t|
      t.string :title,               null: false
      t.text :body,                  null: false
      t.timestamps
    end
  end
end
