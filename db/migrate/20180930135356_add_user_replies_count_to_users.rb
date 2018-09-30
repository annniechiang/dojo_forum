class AddUserRepliesCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :user_user_replies_count, :integer, default: 0
  end
end
