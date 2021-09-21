class ListsController < ApplicationController
  before_action :set_list, only: [:show, :destroy]
  skip_before_action :authenticate_user!, only: :index

  def index
    @lists = List.all.order(:name)
  end

  def show
    @bookmark = Bookmark.new
    @movies = Movie.all.order(:title)
    @review = Review.new
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to @list
    else
      render 'new'
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :image_url, :image)
  end
end
