require 'will_paginate/array'

class ListsController < ApplicationController

	def index
		@query = params[:query]

    if @query
			@type = "query"
			@lists = List.where(title: /#{@query}/)
      @total_records = @lists.count
		else
			@lists = List.all.shuffle.paginate(:page => params[:page], :per_page => 10)
		end
	end

  def show
    @list = List.find(params[:id])

  end

	def new
		@list = List.new
		@list.title = params[:title]
		@list.description = params[:description]
		@list.user = current_user

		respond_to do |format|
			if @list.save!
	      format.json { render json: { status: :success, message: 'Lista adicionada com sucesso!', id: @list.id } }
			else
	      format.json { render json: { status: :error, message: 'Erro ao salvar lista!'}}
	    end
    end
	end

	def add_to
		@list = List.find(params[:list_id])
		@movie = Movie.find(params[:movie_id])

    @list.movies << @movie unless @list.movies.include?(@movie)

		respond_to do |format|
			if @list.save!
	      format.json { render json: { status: :success, message: 'Filme adicionado a lista!'} }
			else
	      format.json { render json: { status: :error, message: 'Erro ao adicionar filme!'}}
	    end
    end
	end

	def delete
    puts "AQUIIIIIIII"
		@list = List.find(params[:id])
		respond_to do |format|
			if @list.destroy!
				format.json { render json: { status: :success, message: 'Lista removida com sucesso!'} }
			else
				format.json { render json: { status: :error, message: 'Erro ao remover lista!'}}
			end
		end
	end
end
