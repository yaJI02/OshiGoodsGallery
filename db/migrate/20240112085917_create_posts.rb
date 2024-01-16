class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body
      t.integer :purchase_cost
      t.date :bought_at
      t.integer :post_type, default: 0, null: false
      t.integer :purchase_status, default: 0, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
