FactoryBot.define do
  factory :admin_user, class: User do
    name {'admin_name'}
    email {'admin_email1@gmail.com'}
    password {'adminuser'}
    password_confirmation {'adminuser'}
    admin {true}
  end
  factory :basic_user, class: User do
    name {'basic_name'}
    email {'basic_email@gmail.com'}
    password {'basicuser'}
    password_confirmation {'basicuser'}
    admin {false}
  end
    factory :basic2_user, class: User do
    name {'basic2_name'}
    email {'basic2_email@gmail.com'}
    password {'basic2user'}
    password_confirmation {'basic2user'}
    admin {false}
  end
end