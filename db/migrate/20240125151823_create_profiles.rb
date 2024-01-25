class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :avatar
      t.string :sns_account
      t.integer :display_tag_type, null: false, default: 0
      t.boolean :is_display_dislike_tag, null: false, default: true
      t.references :user, null: false, foreign_key: true, index: true
      t.references :post, foreign_key: true, index: true

      t.timestamps
    end
  end
end
