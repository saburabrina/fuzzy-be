class UserMoviesController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = Movie.find(params[:user_movie][:movie_id])
    current_user.movies << @movie
    @user_movie = current_user.user_movies.find_by(movie_id: @movie.id)
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end

  def create_many
    user_movies = JSON.parse request.raw_post
    user_movies.each do |user_movie|
        _user_movie = UserMovie.new({user_id: current_user['id'], movie_id: user_movie['movie_id'], score: user_movie['score']})
        return render json: { errors: _user_movie.errors }, status: 500 if !_user_movie.save
    end
  end

  def update
    @user_movie = current_user.user_movies.find_by(movie_id: params[:user_movie][:movie_id])
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end
end
