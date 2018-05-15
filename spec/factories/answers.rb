FactoryBot.define do
  factory :answer do
    body 'MyText'
    association :user
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    question
    association :user
  end
end