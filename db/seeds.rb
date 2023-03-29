# db/seeds.rb

# Create users
users = User.create([
    { name: 'John' },
    { name: 'Jane' },
    { name: 'Bob' },
    { name: 'Alice' },
    { name: 'David' },
    { name: 'Lisa' },
    { name: 'Mike' },
    { name: 'Sara' },
    { name: 'Tom' },
    { name: 'Emily' }
  ])

  # Create sleep records for users
  users.each do |user|
    rand(1..5).times do
      clock_in_time = Faker::Time.between(from: 1.week.ago, to: Time.current, format: :default)
      clock_out_time = Faker::Time.between(from: clock_in_time, to: Time.current, format: :default)
      user.sleep_records.create(
        clock_in_time: clock_in_time,
        clock_out_time: clock_out_time
      )
    end
  end

  # Create follows between users
  users[0..3].each do |follower|
    users[4..9].each do |followed_user|
      Follow.create(follower: follower, followed_user: followed_user)
    end
  end
  