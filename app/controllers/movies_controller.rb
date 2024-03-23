class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = Movie.all
    @movies.each do |movie|
      movie.current_user = current_user
    end
    respond_to do |format|
      format.html
      format.json { render json: @movies.to_json(methods: [:average_score, :user_score]) }
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "Movie was successfully created."
    else
      render :new
    end
  end

  def create_many
    movies = request.raw_post
    job_id = CreateManyMoviesJob.perform_async movies
    render json: { job_id: job_id }, status: 200
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :director)
  end
end
