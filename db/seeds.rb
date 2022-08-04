20.times do |n|
  name = "Example #{n+1}"
  email = "example-#{n+1}@railstutorial.org"
  password = "123456"
  User.create!(name: name,
  email: email,
  password: password,
  password_confirmation: password,
)
end

10.times do |n|
  name = "Example category #{n+1}"
  Category.create!(name: name)
end

40.times do |n|
  category_id = Category.ids.sample
  name = "Example tour #{n+1}"
  description = "lorem" * 2
  price = 30
  avg_rating = n % 5
  date1 = Time.now - 60 * 60 * 24 * 5
  date2 = Time.now
  start_date = Time.at((date2.to_f - date1.to_f)*rand + date1.to_f)
  end_date = start_date + 60 * 60 * 24 * 3
  image = File.open("app/assets/images/tour-4.jpg")
  tour = Tour.create(name: name,
               description: description,
               price: price,
               avg_rating: avg_rating,
               start_date: start_date,
               end_date: end_date
)
  tour.image.attach(io: image, filename: "tour-4.jpg")
  tour.category_id = category_id
  tour.save!
end
