class MovieRecommender
  include Predictor::Base

  limit_similarities_to 500

  input_matrix :location, weight: 0.5 #Localizacao dos usuarios
  input_matrix :seen, weight: 1.5 #filmes vistos pelo usuario
  input_matrix

  input_matrix :users, weight: 3.0
  input_matrix :tags, weight: 2.0
  input_matrix :topics, weight: 1.0, measure: :sorensen_coefficient # Use Sorenson over Jaccard

end
