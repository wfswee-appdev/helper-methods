class MoviesController < ApplicationController
  def new
    @the_movie = Movie.new

   # render template: "movies/new" # we can leave off "movies/new" because movies matches the controller name and new matches method name...we can also just remove this entirely because of those matches
  end

  def index
    matching_movies = Movie.all

    @list_of_movies = matching_movies.order({ :created_at => :desc })

    respond_to do |format|
      format.json do
        render json: @list_of_movies
      end

      format.html #do
      #  render template: "movies/index"
      #end
    end
  end

  def show
    the_id = params.fetch(:id)

    matching_movies = Movie.where({ :id => the_id })

    @the_movie = matching_movies.first

    # render template: "movies/show"
  end

  def create
    @the_movie = Movie.new
    @the_movie.title = params.fetch("query_title")
    @the_movie.description = params.fetch("query_description")

    if @the_movie.valid?
      @the_movie.save
      redirect_to(movies_url, notice: "Movie created successfully." )
    else
      render "new" # we dropped movies/ here because it matches the contorller
    end
  end

  def edit
    the_id = params.fetch(:id)

    matching_movies = Movie.where({ :id => the_id })

    @the_movie = matching_movies.first
  end

  def update
    the_id = params.fetch(:id)
    the_movie = Movie.where({ :id => the_id }).first

    the_movie.title = params.fetch("query_title")
    the_movie.description = params.fetch("query_description")

    if the_movie.valid?
      the_movie.save
      redirect_to movie_url(the_movie), notice: "Movie updated successfully."
    else
      redirect_to movie_url(themovie), alert: "Movie failed to update successfully."
    end
  end

  def destroy
    the_id = params.fetch(:id)
    the_movie = Movie.where({ :id => the_id }).first

    the_movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
