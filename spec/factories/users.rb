# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "MyString"
    uid "MyString"
    username "MyString"
    name "MyString"
    access_token "MyString"
    access_token_secret "MyString"
  end
end
