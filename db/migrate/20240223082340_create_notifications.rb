class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :subject, null: false, polymorphic: true
      t.references :user, null: false, foreign_key: true
      t.integer :action_type, null: false
      t.boolean :checked, null: false, default: false

      t.timestamps
    end
  end
end
