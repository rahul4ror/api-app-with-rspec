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
      articles = create_list :article, 2  #(create_list method is provides by fatory_bot to create n number of object)

      # get :index
      subject

      # These are used in every test in future so they are moved to support/json_api_helpers.rb and they get automatically includes every test
      # json = JSON.parse(response.body)
      # json_data = json['data']

      articles.each_with_index do |article, index|
        expect(json_data[index]['attributes']).to eq(
          {
            "title" => article.title,
            "content" => article.content,
            "slug" => article.slug
          }
        )
      end
    end
  end
end