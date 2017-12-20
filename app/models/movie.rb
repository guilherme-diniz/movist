class Movie
  include Mongoid::Document

  has_and_belongs_to_many :users
  has_and_belongs_to_many :lists

  field :tmdb_id, type: Integer
  field :title, type: String
  field :overview, type: String
  field :image, type: String
  field :movielens_id, type: String

  rateable range: (1..10), raters: User
end
