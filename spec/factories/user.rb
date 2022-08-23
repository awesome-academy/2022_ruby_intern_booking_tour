FactoryBot.define do
  factory :user_example1, class: User do
    name{"khoa1"}
    email{"khoa1@gmail.com"}
    password{"123456"}
    password_confirmation{"123456"}
    activated{true}
  end

  factory :user_example2, class: User do
    name{"khoa2"}
    email{"khoa2@gmail.com"}
    password{"123456"}
    password_confirmation{"123456"}
    activated{true}
  end

  factory :admin, class: User do
    name{"admin"}
    email{"admin@gmail.com"}
    role{0}
    password{"123456"}
    password_confirmation{"123456"}
    activated{true}
  end
end
