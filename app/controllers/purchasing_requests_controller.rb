class PurchasingRequestsController < ApplicationController
  before_action :set_purchasing_request, only: [:show, :edit, :update, :destroy]
  before_action :set_suppliers, only: [:new, :create]

  def index
    @purchasing_requests = PurchasingRequest.all
  end

  def show; end

  def new
    @purchasing_request = PurchasingRequest.new
    build_request_items
  end

  def create
    @purchasing_request = PurchasingRequest.new(purchasing_request_params)
    @purchasing_request.user = current_user
    if @purchasing_request.save
      redirect_to @purchasing_request, notice: 'Purchasing request was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @purchasing_request.update(purchasing_request_params)
      redirect_to purchasing_requests_path, notice: 'Purchasing request was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @purchasing_request.destroy
    redirect_to purchasing_requests_path, notice: 'Purchasing request was successfully destroyed.'
  end

  private

  def set_purchasing_request
    @purchasing_request = PurchasingRequest.find(params[:id])
  end

  def set_suppliers
    @suppliers = Supplier.all.includes(:wines)
  end

  def build_request_items
    @suppliers.each do |supplier|
      supplier.wines.each do |wine|
        @purchasing_request.purchasing_request_items.build(wine: wine, quantity: 0)
      end
    end
  end

  def purchasing_request_params
    params.require(:purchasing_request).permit(:supplier_id, :delivery_date, :delivery_time_slot, purchasing_request_items_attributes: [:id, :wine_id, :quantity])
  end
end
