class MoviesController < ApplicationController
	before_action :authenticate_user!

	def index
		@query = params[:query]

		if @query
			@type = "query"
			@data = Tmdb::Search.movie(@query)
			@data.results += Tmdb::Search.movie(@query, page: 2).results if @data.total_pages > 1
			@total_records = @data.total_records
		else
			@type = "popular"
			@data = Tmdb::Discover.movie
			@data.results += Tmdb::Discover.movie(page: 2).results
		end

		@movies = MoviesHelper.get_movies(@data.results)
	end

	def show
		@movie = Movie.find(params[:id]) rescue nil
		@details = Tmdb::Movie.detail(@movie.tmdb_id) if @movie
		@keywords = Tmdb::Movie.keywords(@movie.tmdb_id) if @movie
		@cast = Tmdb::Movie.cast(@movie.tmdb_id)[0..5] if @movie
		@director = Tmdb::Movie.crew(@movie.tmdb_id).select{|c| c.job == 'Director'} if @movie
		@video = Tmdb::Movie.videos(@movie.tmdb_id) if @movie
	end

	def seen
		@movie = Movie.find(params[:id]) rescue nil

		if @movie
			current_user.movies << @movie
			current_user.save!
		end


		respond_to do |format|
			if @movie.nil?
	      format.json { render json: { status: :error, message: 'Filme não existe!' } }
			else
	      format.json { render json: { status: :success, message: 'Filme marcado como visto!'}}
	    end
    end

	end

	def unseen
		@movie = Movie.find(params[:id]) rescue nil

		if @movie
			current_user.movies -= [@movie]
			current_user.save!
		end


		respond_to do |format|
			if @movie.nil?
	      format.json { render json: { status: :error, message: 'Filme não existe!' } }
			else
	      format.json { render json: { status: :success, message: 'Filme marcado como não visto!'}}
	    end
    end
	end

	def rate
		@movie = Movie.find(params[:id])
		@rate = params[:rate]

		@movie.rate @rate, current_user unless @movie.rated_by? current_user

		current_user.like(@movie) if @rate.to_i >= 6
		current_user.dislike(@movie) if @rate.to_i < 6

		respond_to do |format|
			if @movie.save!
	      format.json { render json: { status: :success, message: 'Avaliação salva com sucesso!'}}
			else
	      format.json { render json: { status: :error, message: 'Erro ao salvar avaliação!' } }
	    end
    end
	end
end
