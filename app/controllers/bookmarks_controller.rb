class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
    @movies = Movie.all
  end

  def create
    if params[:list_id]
      create_list
    else
      create_movie
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to @bookmark.list
  end

  private

  def list_bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
    # @comment = params[:bookmark][:comment]
    # @movie = Movie.find(params[:bookmark][:movie])
  end

  def movie_bookmark_params
    params.require(:bookmark).permit(:comment, :list_id)
    # @comment = params[:bookmark][:comment]
    # @movie = Movie.find(params[:bookmark][:movie])
  end

  def create_list
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(list_bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      @review = Review.new
      @movies = Movie.all.order(:title)
      @movie = @bookmark.movie
      render 'lists/show'
    end
  end

  def create_movie
    @movie = Movie.find(params[:movie_id])
    @bookmark = Bookmark.new(movie_bookmark_params)
    @bookmark.movie = @movie
    if @bookmark.save
      redirect_to list_path(@bookmark.list)
    else
      @lists = List.all.order(:name)
      @list = @bookmark.list
      render 'movies/show'
    end
  end
end
