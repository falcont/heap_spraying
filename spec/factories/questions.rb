FactoryGirl.define do
  factory :question do
    title 'Вопрос_1'
    body 'Тело вопроса'
    association :user
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end
end
