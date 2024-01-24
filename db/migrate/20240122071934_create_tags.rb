class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.integer :tag_type, null: false, default: 0

      t.timestamps
    end
  end
end
