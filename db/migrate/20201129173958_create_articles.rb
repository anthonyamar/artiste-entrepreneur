class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :contentful_id, null: false
      t.string :slug, null: false
      t.timestamps
    end
  end
end
