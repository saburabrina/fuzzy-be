class CreateManyMoviesJob
  include Sidekiq::Job
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  sidekiq_options retry: false

  def perform(movies)
    _movies = JSON.parse movies

    Movie.transaction do
      _movies.each do |movie|
        new_movie = Movie.new(movie)
        raise new_movie.errors.messages if !new_movie.save
      end
    end
  end
end
