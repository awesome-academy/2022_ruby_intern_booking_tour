# User.destroy_all
# User.create!(name: "Example User",
#   email: "example@railstutorial.org",
#   password: "foobar",
#   password_confirmation: "foobar",
#   role: 0
# )

# 99.times do |n|
#   name = "khoa-#{n+1}"
#   email = "example-#{n+1}@railstutorial.org"
#   password = "password"
#   User.create!(name: name,
#     email: email,
#     password: password,
#     password_confirmation: password,
#   )
#   end

# Category.destroy_all
# 10.times do |n|
#     name = "Example category #{n+1}"
#     Category.create!(name: name)
#   end

# Tour.destroy_all
# 40.times do |n|
#     category_id = (n % 9) + 1
#     name = "Example tour #{n+1}"
#     description = "lorem" * 20
#     price = 30
#     avg_rating = n % 5
#     date1 = Time.now - 60 * 60 * 24 * 5
#     date2 = Time.now
#     start_date = Time.at((date2.to_f - date1.to_f)*rand + date1.to_f)
#     end_date = start_date + 60 * 60 * 24 * 3
#     image = File.open("app/assets/images/tour-4.jpg")
#     stock = 1
#     tour = Tour.create(name: name,
#                  description: description,
#                  price: price,
#                  avg_rating: avg_rating,
#                  start_date: start_date,
#                  end_date: end_date,
#                  stock: stock
#   )
#     tour.image.attach(io: image, filename: "tour-4.jpg")
#     tour.category_id = category_id
#     tour.save!
#   end

# Review.destroy_all
# 100.times do |n|
#     content = "Example review #{n+1}"
#     rating = (n % 9 ) + 1
#     user_id = (n % 9) + 1
#     tour_id = (n % 9) + 1
#     review = Review.create(content: content, rating: rating)
#     review.user_id = user_id
#     review.tour_id = tour_id
#     review.save!
#   end

# 50.times do |n|
#   user_id = n + 1
#   tour_id = (n % 39) + 1
#   quantity = (n % 10) + 1
#   total_price = quantity * Tour.find_by(id: tour_id).price
#   tour_request = TourRequest.create(user_id: user_id, tour_id: tour_id, quantity: quantity, total_price: total_price)
#   tour_request.save!
# end
