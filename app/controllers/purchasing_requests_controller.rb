class PurchasingRequestsController < ApplicationController
  before_action :set_purchasing_request, only: [:show, :edit, :update, :destroy]
  before_action :set_suppliers, only: [:new, :create]

  def index
    @purchasing_requests = PurchasingRequest.all
  end

  def show
    @purchasing_request = PurchasingRequest.includes(:notes).find(params[:id])
    @note = Note.new
  end


  def new
    @purchasing_request = PurchasingRequest.new
    build_request_items
  end

  def create
    @purchasing_request = PurchasingRequest.new(purchasing_request_params)
    @purchasing_request.user = current_user
    @purchasing_request.approval_status = 'pending'
    if @purchasing_request.save
      redirect_to @purchasing_request, notice: 'Purchasing request was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    puts params.inspect # Output the parameters to the console for debugging
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

  def approve
    @purchasing_request = PurchasingRequest.find(params[:id])
    @purchasing_request.update(approval_status: 'approved')
    redirect_to @purchasing_request
  end

  def reject
    @purchasing_request = PurchasingRequest.find(params[:id])
    @purchasing_request.update(approval_status: 'rejected')
    redirect_to @purchasing_request
  end

  def request_more_info
    @purchasing_request = PurchasingRequest.find(params[:id])
    @purchasing_request.update(approval_status: 'pending', note: params[:message])

    redirect_to @purchasing_request
  end

  def create_note
    @purchasing_request = PurchasingRequest.find(params[:id])
    @note = @purchasing_request.notes.new(note_params)
    @note.user = current_user
    if @note.save
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end

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
