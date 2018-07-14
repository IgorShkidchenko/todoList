FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }			
  

  factory :userWithProject do
    after(:create) do |user|
      create(:project, user: user)
    end 
  end
  end
end
