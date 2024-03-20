class CreateManyMoviesJob
  include Sidekiq::Job

  def perform(movies)
    puts "VO CRIA UM MONTE DE MOVIE LKKKKKKK"
    puts movies
    # Do something
  end
end
