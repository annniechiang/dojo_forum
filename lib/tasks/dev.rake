namespace :dev do
  task user: :environment do
    30.times do |i|
      name = FFaker::Name.first_name

      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: "12345678",
        intro: FFaker::Lorem.sentence(30),
        avatar: FFaker::Avatar.image
      )

      user.save
      puts user.name
    end
    puts "Now you have #{User.count} users."
  end

  task post: :environment do
    Post.destroy_all

    100.times do |i|
      Post.create(
        title: FFaker::Lorem.phrase,
        photo: "http://via.placeholder.com/300x300",
        content: FFaker::Lorem.paragraph,
        user: User.all.sample,
        category: Category.all.sample
      )
    end
    puts "Now you have #{Post.count} posts."
  end

  # reply
  # friendship
end