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
    puts "Now there are #{User.count} users."
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

  task reply: :environment do
    500.times do |i|
      Reply.create(
        content: FFaker::Lorem::paragraph[1..rand(1..200)],
        user: User.all.sample,
        post: Post.all.sample
      )
    end
    puts "Now there are #{Reply.count} replies"
  end

  # friendship
end