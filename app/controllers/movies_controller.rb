class MoviesController < ApplicationController
  def new
    @movie = Movie.new

   # render template: "movies/new" # we can leave off "movies/new" because movies matches the controller name and new matches method name...we can also just remove this entirely because of those matches
  end

  def index
    @movies = Movie.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html #do
      #  render template: "movies/index"
      #end
    end
  end

  def show
    @movie = Movie.find(params.fetch(:id))
    # the_id = params.fetch(:id)
    # matching_movies = Movie.where(:id => the_id)
    # @the_movie = matching_movies.first

    # render template: "movies/show"
  end

  def create
    @movie = Movie.new
    @movie.title = params.fetch("title")
    @movie.description = params.fetch("description")

    if @movie.valid?
      @movie.save
      redirect_to(movies_url, notice: "Movie created successfully." )
    else
      render "new" # we dropped movies/ here because it matches the contorller
    end
  end

  def edit
    @movie = Movie.find(params.fetch(:id))

  end

  def update
    movie = Movie.find(params.fetch(:id))
    movie.title = params.fetch("title")
    movie.description = params.fetch("description")

    if movie.valid?
      movie.save
      redirect_to movie_url(movie), notice: "Movie updated successfully."
    else
      redirect_to movie_url(themovie), alert: "Movie failed to update successfully."
    end
  end

  def destroy
    movie = Movie.find(params.fetch(:id))

    movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
