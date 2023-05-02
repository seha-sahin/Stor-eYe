class PurchasingRequestsController < ApplicationController
  before_action :set_purchasing_request, only: [:show, :edit, :update, :destroy]

  def index
    @purchasing_requests = PurchasingRequest.all
  end

  def show
  end

  def new
    @purchasing_request = current_user.purchasing_requests.build
  end

  def create
    @purchasing_request = PurchasingRequest.new(purchasing_request_params)

    if @purchasing_request.save
      redirect_to @purchasing_request
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @purchasing_request.update(purchasing_request_params)
      redirect_to @purchasing_request
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    purchasing_request.destroy
    redirect_to purchasing_requests_path
  end

  private

  def purchasing_request_params
    params.require(:purchasing_request).permit(:pr_quantity, :delivery_date, :delivery_time_slot, :user_id, :supplier_id)
  end

  def set_purchasing_request
    @purchasing_request = PurchasingRequest.find(params[:id])
  end
end
