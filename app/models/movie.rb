class Movie < ApplicationRecord
  has_many :user_movies
  has_many :users, through: :user_movies

  attr_accessor :current_user

  def average_score
    user_movies.average(:score).to_f
  end

  def user_score
    _user_movie = user_movies.find_by(user_id: current_user.id)
    return nil if !_user_movie
    return _user_movie[:score]
  end
end
