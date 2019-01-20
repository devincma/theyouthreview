class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title,               null: false
      t.text :body,                  null: false

      t.boolean :is_featured,        default: false
      t.boolean :is_featured_today,  default: false

      t.timestamps
    end
  end
end
