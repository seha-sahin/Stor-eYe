class PurchasingRequestsController < ApplicationController
  before_action :set_purchasing_request, only: [:show, :edit, :update, :destroy]

  def index
    @purchasing_requests = PurchasingRequest.all
  end

  def show
  end

  def new
    @purchasing_request = current_user.purchasing_requests.build
    @supplier = @purchasing_request.build_supplier
  end

  def create
    @purchasing_request = PurchasingRequest.new(purchasing_request_params)
    @purchasing_request.user = current_user
    @purchasing_request.supplier = Supplier.find(params[:purchasing_request][:supplier_id])

    if @purchasing_request.save
      redirect_to purchasing_requests_path, notice: 'Purchasing request was successfully created.'
    else
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
    params.require(:purchasing_request).permit(:pr_quantity, :delivery_date, :delivery_time_slot, :supplier_id, supplier_attributes: [:name, :phone_number, :email])
  end

  def set_purchasing_request
    @purchasing_request = PurchasingRequest.find(params[:id])
  end
end
