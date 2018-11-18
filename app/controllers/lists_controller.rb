class ListsController < ApplicationController
  before_action :authentification_required
  
  def index
    @list = List.new
    @lists = List.all
  end
  
  def show
    @list = List.find(params[:id])
    @item = Item.new
  end
  
  def create
    @list = List.new(list_params)
    
    if @list.save
      redirect_to list_url(@list)
    else
      # also need to reload all the lists
      @lists = List.all
      render :index
    end
  end
  
  private 
  
  def list_params
    params.require(:list).permit(:name)
  end
end
