# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Category

Category.destroy_all

category_list = [
  { name: "商業"},
  { name: "科技" },
  { name: "心理" },
  { name: "美食" },
  { name: "旅遊" },
  { name: "生活" },
  { name: "新奇" }
]

category_list.each do |category|
  Category.create( name: category[:name] )
end

puts "Category created!"

# Default admin

User.create(name: "Admin", email: "admin@example.com", password: "12345678", role: "admin")
puts "Default admin created!"