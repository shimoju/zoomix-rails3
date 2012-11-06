# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :url do
    url "MyString"
    original_url "MyString"
    post nil
  end
end
