class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = Movie.all
    respond_to do |format|
      format.html
      format.json { render json: @movies.to_json(methods: :average_score) }
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
    movies = JSON.parse request.raw_post
    #movies.each do |movie|
    #    _movie = Movie.new(movie)
    #    puts _movie
    #    render json: {}, status: 500 if !_movie.save
    #end
    render json: {}, status: 500 if !Movie.create(movies)
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :director)
  end
end
