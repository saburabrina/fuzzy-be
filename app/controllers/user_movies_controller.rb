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
    user_movies = request.raw_post
    job_id = SubmitManyScoresJob.perform_async(user_movies, current_user.to_json)
    render json: { job_id: job_id }, status: 200
  end

  def update
    @user_movie = current_user.user_movies.find_by(movie_id: params[:user_movie][:movie_id])
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end
end
