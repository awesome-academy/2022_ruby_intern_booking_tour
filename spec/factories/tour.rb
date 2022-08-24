FactoryBot.define do
  factory :tour_example_1, class: Tour do
    name{"Name Tour1 "}
    description{"abc"}
    start_date{Time.zone.parse('2022-09-11 21:00')}
    end_date{Time.zone.parse('2022-10-11 21:00')}
    price{11}
    stock{5}
    avg_rating{1}
  end

  factory :tour_example_2, class: Tour do
    name{"Name Tour2 "}
    description{"abc"}
    start_date{Time.zone.parse('2022-08-11 21:00')}
    end_date{Time.zone.parse('2022-10-11 21:00')}
    price{10}
    stock{6}
    avg_rating{1}
  end
end
