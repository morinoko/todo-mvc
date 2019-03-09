class ItemsController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @item = @list.items.build(item_params)
    
    if @item.save
      respond_to do |f|
        # if the request is asking for HTML, redirect to the list
        f.html {redirect_to list_path(@list)}
        # if the request is asking for JSON, render a JSON representation of the list
        f.json {render :json => @item}
      end
    else
      render 'lists/show' #wrong render?
    end
  end
  
  def update
    @list = List.find_by(id: params[:list_id])
    @item = @list.items.find_by(id: params[:id])
    @item.update(item_params)
    
    redirect_to list_path(@item.list)
  end
  
  def destroy
    @item = Item.find_by(id: params[:id])
    @item.destroy
    
    respond_to do |f|
      f.json {render :json => @item}
      f.html {redirect_to list_path(@item.list)}
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :status)
  end
end
