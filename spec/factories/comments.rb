FactoryBot.define do
  factory :comment do
    body "comment test"
    association :user
  end
end