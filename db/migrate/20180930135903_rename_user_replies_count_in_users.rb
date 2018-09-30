class RenameUserRepliesCountInUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :user_user_replies_count, :user_replies_count
  end
end
