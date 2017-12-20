class MovieNeo 
  include Neo4j::ActiveNode

  has_many :in, :users_rated, origin: :rated_movies, model_class: :UserNeo
  has_many :in, :users_list, origin: :list_movies, model_class: :UserNeo

  has_many :out, :same_list_movies, type: :SAME_LIST_MOVIES, model_class: :MovieNeo

  id_property :mongo_id
end