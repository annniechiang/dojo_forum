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

    # Default admin
    User.create(name: "Admin", email: "admin@example.com", password: "12345678", intro: FFaker::Lorem::sentence(30), role: "admin")
    puts "Default admin created!"
  end

  task category: :environment do
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
  end

  task post: :environment do
    Post.destroy_all

    100.times do |i|
      if Random.rand(10) < 8
        s = true
      else
        s = false
      end

      authority_list = ["All", "Friend", "Only you"]

      Post.create(
        title: FFaker::Lorem.phrase,
        photo: "http://via.placeholder.com/300x300",
        content: FFaker::Lorem.paragraph,
        user: User.all.sample,
        category: Category.all.sample,
        status: s,
        authority: authority_list[rand(0..2)]
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

  task last_reply: :environment do
    Post.all.each do |post|
      if post.replies_count > 0
        post.last_replied_at = post.replies.order(created_at: :desc).first.created_at
        post.save
      end
    end
    puts "done"
  end

  task collect: :environment do
    600.times do |i|
      Collect.create(
        user: User.all.sample,
        post: Post.all.sample
      )
    end
    puts "Now there are #{Collect.count} collects"
  end

  task friend: :environment do
    Friendship.destroy_all

    600.times do |i|
      user = User.all.sample
      friend_id = User.all.sample.id
      friendship = Friendship.where(user: User.find(friend_id), friend_id: user.id).first
      
      if friendship == nil && user.id != friend_id
        Friendship.create(
          user: user,
          friend_id: friend_id,
          status: Random.rand(10) < 7 ? true : false
        )
      end
    end

    puts "Now there are #{Friendship.count} friendships"
  end

  # 已加至 post
  task post_status: :environment do
    count = 0
    Post.all.each do |post|
      if Random.rand(10) < 8
        post.status = true
        post.save
        count+=1
      end
    end
    puts "now have #{count} published posts"
  end

  # 已加至 post
  task post_authority: :environment do
    authority_list = ["All", "Friend", "Only you"]
    Post.all.each do |post|
      post.authority = authority_list[rand(0..2)]
      post.save
    end
    puts "authority done"
  end
end