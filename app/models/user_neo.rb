class UserNeo
  include Neo4j::ActiveNode

  has_many :out, :count_users_list, type: :SAME_LIST_COUNT, model_class: :UserNeo
  has_many :both, :same_hate_count_users, type: :SAME_HATE_COUNT, model_class: :UserNeo

  has_many :out, :rated_movies, type: :RATED_MOVIES, model_class: :MovieNeo
  has_many :out, :list_movies, type: :LIST_MOVIES, model_class: :MovieNeo

  id_property :mongo_id

end