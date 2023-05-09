class PurchasingRequestItemsController < ApplicationController
  before_action :set_purchasing_request, only: [:new, :create, :edit, :update]
  before_action :set_purchasing_request_item, only: [:edit, :update]

  def new
    @purchasing_request_item = @purchasing_request.purchasing_request_items.build
    @wines = @purchasing_request.supplier.wines
  end

  def edit
    @wines = @purchasing_request.supplier.wines
  end

  def create
    @purchasing_request_item = @purchasing_request.purchasing_request_items.build(purchasing_request_item_params)
    @purchasing_request_item.wine = @purchasing_request.supplier.wines.find_by(id: params[:purchasing_request_item][:wine_id])

    if @purchasing_request_item.save
      redirect_to @purchasing_request, notice: 'Purchasing request item was successfully created.'
    else
      @wines = @purchasing_request.supplier.wines
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    @purchasing_request_item.wine = @purchasing_request.supplier.wines.find_by(id: params[:purchasing_request_item][:wine_id])

    if @purchasing_request_item.update(purchasing_request_item_params)
      redirect_to @purchasing_request, notice: 'Purchasing request item was successfully updated.'
    else
      @wines = @purchasing_request.supplier.wines
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def set_purchasing_request
    @purchasing_request = PurchasingRequest.find(params[:purchasing_request_id])
  end

  def set_purchasing_request_item
    @purchasing_request_item = @purchasing_request.purchasing_request_items.find(params[:id])
  end

  def purchasing_request_item_params
    params.require(:purchasing_request_item).permit(:wine_id, :quantity)
  end
end
