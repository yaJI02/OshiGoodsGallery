class AddIndexPostTag < ActiveRecord::Migration[7.0]
  def change
    add_index :post_places, [:post_id, :place_id], unique: true
    add_index :post_tags, [:post_id, :tag_id], unique: true
    add_index :post_stamps, [:post_id, :user_id, :stamp], unique: true
  end
end
