class CreateManyMoviesJob
  include Sidekiq::Job

  def perform(movies)
    _movies = JSON.parse movies
    Movie.create(_movies)
    puts "Movies Creation on Background"
  end
end
