module MoviesHelper

	def self.get_movies tmdb_data
		movies = Movie.in(tmdb_id: tmdb_data.map{|m| m.id})

		missing_ids = movies.map{|m| m.tmdb_id} - tmdb_data.map{|m| m.id}
		missing_movies = tmdb_data.select {|m| missing_ids.include?(m.id)}

		missing_movies.each do |tmdb_movie|
			data = {}
			data[:tmdb_id] = tmdb_movie.id
			data[:title] = tmdb_movie.title
			data[:overview] = tmdb_movie.overview
			data[:image] = "https://image.tmdb.org/t/p/w342#{tmdb_movie.poster_path}" if tmdb_movie.poster_path
			
			movie = Movie.new(data)
			movie.save!
			movies << movie
		end

		movies
	end
end
