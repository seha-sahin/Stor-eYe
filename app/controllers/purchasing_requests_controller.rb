class PurchasingRequestsController < ApplicationController
  before_action :set_purchasing_request, only: [:show, :edit, :update, :destroy]

  def index
    @purchasing_requests = PurchasingRequest.all
    @wines_by_supplier = Wine.includes(:supplier).all.group_by { |wine| wine.supplier.id }
  end

  def show
  end

  def new
    @purchasing_request = PurchasingRequest.new(supplier_id: params[:supplier_id])
    @suppliers = Supplier.all.includes(:wines)
    @wines_by_supplier = @suppliers.each_with_object({}) do |supplier, obj|
      obj[supplier.id] = supplier.wines.order(maker: :asc)
    end
    @purchasing_request.purchasing_request_items.build
  end

  def create
    @purchasing_request = PurchasingRequest.new(purchasing_request_params)
    @purchasing_request.user = current_user
    supplier_id = params[:purchasing_request][:supplier_id]
    @purchasing_request.supplier = Supplier.find_by(id: supplier_id)

    if @purchasing_request.supplier.nil?
      flash[:alert] = "Supplier with ID #{supplier_id} could not be found"
      render :new, status: :unprocessable_entity
    elsif @purchasing_request.save
      redirect_to purchasing_requests_path, notice: 'Purchasing request was successfully created.'
    else
      flash[:alert] = 'There was an error creating the purchasing request.'
      render :new, status: :unprocessable_entity
    end
  end


  def edit
  end

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

  def purchasing_request_params
    params.require(:purchasing_request).permit(
      :delivery_date,
      :delivery_time_slot,
      :supplier_id,
      supplier_attributes: [:name, :phone_number, :email],
      purchasing_request_items_attributes: [:id, :quantity, :wine_id, :_destroy]
    )
  end

  def set_purchasing_request
    @purchasing_request = PurchasingRequest.find(params[:id])
  end
end
