class AddAuthorityToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :authority, :string, default: "All"
  end
end
