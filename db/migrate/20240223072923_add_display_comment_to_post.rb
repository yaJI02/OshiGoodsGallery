class AddDisplayCommentToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :display_comment, :boolean, null: false, default: true
  end
end
