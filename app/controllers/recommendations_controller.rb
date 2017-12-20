class RecommendationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @set = current_user.recommendation_sets[-1] if current_user
  end

  def check_recommendations

    if current_user.likes_count + current_user.dislikes_count < 10
      flash[:alert] = "Avalie mais filmes para ter uma recomendação melhor (minimo de 10)"
      redirect_to recommendations_path and return
    end

    Recommendable::Helpers::Calculations.update_similarities_for(current_user.id)
    Recommendable::Helpers::Calculations.update_recommendations_for(current_user.id)

    @rec_set = RecommendationSet.new
    @rec_set.user = current_user
    @rec_set.save!

    @movies = current_user.recommended_movies[0..20]
    @movies.each do |movie|
      r = Recommendation.new
      r.movie = movie
      r.recommendation_set = @rec_set
      r.save!
    end



    redirect_to recommendations_path
  end

  def rate
    @recommendation = Recommendation.find(params[:id])
    @rate = params[:rate].to_i

    @recommendation.rate @rate, current_user unless @recommendation.rated_by? current_user
    @recommendation.like = @rate >= 6

    @movie = @recommendation.movie
    @movie.rate @rate, current_user unless @movie.rated_by? current_user

    current_user.like(@movie) if @rate.to_i >= 6
    current_user.dislike(@movie) if @rate.to_i < 6

    respond_to do |format|
      if @recommendation.save!
        format.json { render json: { status: :success, message: 'Avaliação salva com sucesso!'}}
      else
        format.json { render json: { status: :error, message: 'Erro ao salvar avaliação!' } }
      end
    end
  end
end
