class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.get_possible_ratings

    @movies = Movie.all

    @selected = @all_ratings
    @checked_ratings_hash = params[:ratings]
    if @checked_ratings_hash
      @selected = @checked_ratings_hash.keys
      @movies = Movie.with_ratings(@selected)
    end

    @sortBy = params[:sort]
    if @sortBy == 'title'
      @movies = @movies.sort_by { |m| m.title }
      @title = 'hilite'
      @addition = '/?sort=title'
    elsif @sortBy == 'releaseDate'
      @movies = @movies.sort_by { |m| m.release_date }
      @releaseDate = 'hilite'
      @addition = '/?sort=releaseDate'
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  # def sortMovies
  #   # @movie = Movie.find(params[:sortBy])
  #   @movies = Movie.all
  #   @movies = @movies.sort_by { |m| m.title }
  #   # sort_by { |m| m.title}
  # end

end
