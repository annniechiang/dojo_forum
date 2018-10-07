class RemoveCountsFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :replies_count
    # remove_column :posts, :viewd_count
  end
end
