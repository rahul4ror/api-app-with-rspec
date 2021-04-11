FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "My awsome article #{n}" }
    sequence(:content) { |n| "The content of my awsome article #{n}" }
    sequence(:slug) { |n| "my-awsome-article-#{n}" }
  end
end
