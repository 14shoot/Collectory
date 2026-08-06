class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.text :body, null: false
      t.integer :status, null: false, default: 0
      t.string :location, null: false

      t.timestamps
    end
  end
end
