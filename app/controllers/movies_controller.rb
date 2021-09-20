class MoviesController < ApplicationController
  def index
    if params[:query]
      @pagy, @movies = pagy(Movie.where("upper(title) LIKE '%#{params[:query].upcase}%'"), items: 30)
    else
      @pagy, @movies = pagy(Movie.all.order(:title), items: 30)
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @bookmark = Bookmark.new
    @lists = List.all.order(:name)
  end
end
