class ListsController < ApplicationController
  before_action :set_list, only: [:show]
  
  def index
    @list = List.new
    @lists = List.all
  end
  
  def show
  end
  
  def create
    @list = List.new(list_params)
    @list.save
    
    redirect_to list_url(@list)
  end
  
  private 
  
  def list_params
    params.require(:list).permit(:name)
  end
  
  def set_list
    @list = List.find(params[:id])
  end
end
