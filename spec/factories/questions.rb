FactoryGirl.define do
  factory :question do
    title 'Заголовок вопроса'
    body 'Текст вопроса'
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end
end
