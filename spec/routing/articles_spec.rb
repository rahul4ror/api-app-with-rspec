require 'rails_helper'

describe "article routes" do
  it "should route to articles index page" do
    expect(get '/articles').to route_to('articles#index')
  end

  it "should route to articles show page" do
    expect(get '/articles/1').to route_to('articles#show', id: '1')
  end

  it "should route to articles create page" do
    expect(post '/articles').to route_to('articles#create')
  end
end