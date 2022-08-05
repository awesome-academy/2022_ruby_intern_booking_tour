FactoryBot.define do
  factory :user do
    name{"example user"}
    email{"exampleemail@gmail.com"}
    password{"password"}
  end

  factory :category do
    name{"example category"}
  end

  factory :tour do
    category
    name{"example tour"}
    description{"example description"}
    price{1}
    avg_rating{1}
    start_date{Time.zone.now}
    end_date{Time.zone.now + 60*60*60}
    category_id{category.id}
    stock{1}
  end

  factory :tour_request do
    tour
    user
    quantity{1}
    total_price{1}
    user_id{user.id}
    tour_id{tour.id}
  end
end
