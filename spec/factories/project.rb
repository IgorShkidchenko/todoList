FactoryGirl.define do
    factory :project do
        name { FFaker::Internet.user_name }
    end 
end