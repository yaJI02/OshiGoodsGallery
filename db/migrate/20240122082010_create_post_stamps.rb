class CreatePostStamps < ActiveRecord::Migration[7.0]
  def change
    create_table :post_stamps do |t|
      t.references :post, null: false, foreign_key: true, index: true
      t.references :user, null: false, foreign_key: true, index: true
      t.integer :stamp, null: false

      t.timestamps
    end
  end
end
