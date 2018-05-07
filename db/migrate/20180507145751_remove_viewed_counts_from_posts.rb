class RemoveViewedCountsFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :viewed_count
  end
end
