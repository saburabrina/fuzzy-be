require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  mocked_movies = [{title: "Movie 1", director: "Director"}, {title: "Movie 2", director: "Director"}]

  before do
    @user = User.create({email: 'email@email', password: 'password'})
    @movies = Movie.create(mocked_movies)

    request.headers["Accept"] = "application/json"
    session[:user_id] = @user.id
  end

  describe "GET /index" do
    it "has a 200 status code and return movies" do
      get :index
      expect(response.status).to eq(200)
      
      body = JSON.parse response.body
      body.each_with_index do |movie, index|
        expect(movie["title"]).to eq mocked_movies[index][:title]
        expect(movie["director"]).to eq mocked_movies[index][:director]
      end
    end
  end

  describe "POST /many" do 
    it "has a 200 status code and returns movies creation job id" do
      post :create_many, body: mocked_movies.to_json

      body = JSON.parse response.body
      expect(response.status).to eq(200)
      expect(response.body["job_id"]).not_to be_nil
    end
  end
end
