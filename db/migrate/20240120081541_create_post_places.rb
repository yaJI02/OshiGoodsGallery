class CreatePostPlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :post_places do |t|
      t.references :post, null: false, foreign_key: true, index: true
      t.references :place, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
