# Generate a bunch of additional users.
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
