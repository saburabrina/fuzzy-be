class SubmitManyScoresJob
    include Sidekiq::Job
    
    def perform(user_movies, current_user)
        _user_movies = JSON.parse user_movies
        user = JSON.parse current_user
        _user_movies.each do |user_movie|
            _user_movie = UserMovie.new({user_id: user['id'], movie_id: user_movie['movie_id'], score: user_movie['score']})
            puts _user_movie.errors.messages if !_user_movie.save
            puts "Submiting Score #{user_movie['score']} to movie #{user_movie['movie_id']}"
        end
    end
end