class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :subject, default: 0, null: false
      t.text :message, null: false
      t.string :login_user

      t.timestamps
    end
  end
end
