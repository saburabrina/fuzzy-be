require 'rails_helper'

RSpec.describe Movie, type: :model do
  context 'get movie' do
    before do
      @movie = Movie.create({title: "Movie", director: "Director"})
      @user1 = User.create({email: 'email@email', password: 'password'})
      user2 = User.create({email: 'e-mail@email', password: 'password'})
      @user_movie1 = UserMovie.create({ user_id: @user1.id, movie_id: @movie.id, score: 7})
      user_movies2 = UserMovie.create({ user_id: user2.id, movie_id: @movie.id, score: 9})
    end

    it 'return average score from movie' do
      expect(@movie.average_score).to eql(8.0)
    end

    it 'return submited score by current user' do
      @movie.current_user = @user1
      expect(@movie.user_score).to eql(@user_movie1.score)
    end
  end
end
