require 'rails_helper'

RSpec.describe UserMoviesController, type: :controller do
  mocked_movies = [{title: "Movie 1", director: "Director"}, {title: "Movie 2", director: "Director"}]

  before do
    @user = User.create({email: 'email@email', password: 'password'})
    @movies = Movie.create(mocked_movies)
    @user_movies = [];
    @movies.each_with_index do |movie, index|
      @user_movies << { user_id: @user.id, movie_id: movie.id, score: index}
    end

    request.headers["Accept"] = "application/json"
    session[:user_id] = @user.id
  end
  
  describe "POST /many" do
    it "has a 200 status code and returns user_movies creation job id" do
      post :create_many, body: @user_movies.to_json

      body = JSON.parse response.body
      expect(response.status).to eq(200)
      expect(response.body["job_id"]).not_to be_nil
    end
  end
end
