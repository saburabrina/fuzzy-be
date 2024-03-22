class Movie < ApplicationRecord
  has_many :user_movies
  has_many :users, through: :user_movies

  attr_accessor :current_user

  def average_score
    user_movies.average(:score).to_f
  end

  def user_score
    _user_movies = user_movies.find_by(user_id: current_user.id)
    return _user_movies[:score]
  end
end
