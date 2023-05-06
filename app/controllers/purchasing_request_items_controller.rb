class PurchasingRequestItemsController < ApplicationController
  before_action :set_purchasing_request_item, only: [:show, :edit, :update, :destroy]

  def index
    @purchasing_request_items = PurchasingRequestItem.all
  end

  def show
  end

  def new
    @purchasing_request_item = PurchasingRequestItem.new
  end

  def edit
  end

  def create
    @purchasing_request_item = PurchasingRequestItem.new(purchasing_request_item_params)

    if @purchasing_request_item.save
      redirect_to @purchasing_request_item, notice: 'Purchasing request item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @purchasing_request_item.update(purchasing_request_item_params)
      redirect_to @purchasing_request_item, notice: 'Purchasing request item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @purchasing_request_item.destroy
    redirect_to purchasing_request_items_url, notice: 'Purchasing request item was successfully destroyed.'
  end

  private

  def set_purchasing_request_item
    @purchasing_request_item = PurchasingRequestItem.find(params[:id])
  end

  def purchasing_request_item_params
    params.require(:purchasing_request_item).permit(:quantity, :purchasing_request_id, :wine_id)
  end
end
