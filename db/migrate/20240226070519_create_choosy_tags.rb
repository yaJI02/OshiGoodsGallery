class CreateChoosyTags < ActiveRecord::Migration[7.0]
  def change
    create_table :choosy_tags do |t|
      t.references :profile, null: false, foreign_key: true, index: true
      t.references :tag, null: false, foreign_key: true, index: true
      t.integer :choosy_type, null: false

      t.timestamps
    end

    add_index :choosy_tags, [:profile_id, :tag_id], unique: true
  end
end
