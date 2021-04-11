require 'rails_helper'

describe ArticlesController do
  describe "#index" do
    subject { get :index} # short-cut to tell what will be called

    it "should return success response" do

      #get :index #(first send reuest to index action)
      subject

      expect(response).to have_http_status(:ok)
    end

    it "should return proper json" do
      create_list :article, 2  #(create_list method is provides by fatory_bot to create n number of object)

      # get :index
      subject

      # These are used in every test in future so they are moved to support/json_api_helpers.rb and they get automatically includes every test
      # json = JSON.parse(response.body)
      # json_data = json['data']

      Article.recent.each_with_index do |article, index|
        expect(json_data[index]['attributes']).to eq(
          {
            "title" => article.title,
            "content" => article.content,
            "slug" => article.slug
          }
        )
      end
    end

    it "should return articles in proper order" do
      old_article = create :article
      new_article = create :article
      subject
      expect(json_data.first['id']).to eq(new_article.id.to_s)
      expect(json_data.last['id']).to eq(old_article.id.to_s)
    end

    it "should paginate results" do
      create_list :article, 3
      get :index, params: { page: 2, per_page: 1 }
      expect(json_data.length).to eq 1
      expected_article = Article.recent.second.id.to_s
      expect(json_data.first['id']).to eq(expected_article)
    end
  end
end