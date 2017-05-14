FactoryGirl.define do
  factory :attachment do
    file File.new("#{Rails.root}/Gemfile")
    association :attachable
  end
end
