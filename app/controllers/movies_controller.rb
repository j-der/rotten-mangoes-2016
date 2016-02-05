class MoviesController < ApplicationController

  def index
    @movies = Movie.all
    @movies = @movies.search(params[:term]) unless params[:term].blank?
    @movies = @movies.runtime(params[:runtime_in_minutes]) unless params[:runtime_in_minutes].blank?
  end

#   def index

#     @movies = Movie.all
#     @movies = @movies.search(params[:term]) unless params[:term].blank?
#     @movies = @movies.runtime(params[:term])

#     if @movies.empty?
#       flash.now[:notice] = "Sorry, no movie matches that criteria!"
#     end
#   end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully."
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :poster_image)
  end

  # def search
  #   @movie = Movie.whatever_search_method_you_defined(params[:q])
  # end
end

