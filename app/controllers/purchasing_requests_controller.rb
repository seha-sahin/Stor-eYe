class PurchasingRequestsController < ApplicationController
  before_action :set_purchasing_request, only: [:show, :edit, :update, :destroy, :delivered]
  before_action :set_suppliers, only: [:new, :create]

  def index
    @purchasing_requests = PurchasingRequest.all
  end

  def show
    @purchasing_request = PurchasingRequest.includes(:notes).find(params[:id])
    @all_purchasing_request_items = PurchasingRequestItem.all
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
      # Notify the manager about the new request
      manager = User.find_by(position: 'manager')
      NewPurchaseRequest.with(purchasing_request: @purchasing_request).deliver(manager) if manager.present?
      redirect_to @purchasing_request, notice: 'Purchasing request was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @purchasing_request.update(purchasing_request_params)
      # Send notification
      manager = User.find_by(position: 'manager')
      notification_type = case @purchasing_request.approval_status
                          when 'approved'
                            PurchaseRequestApproved
                          when 'rejected'
                            PurchaseRequestRejected
                          when 'delivered'
                            PurchaseRequestDelivered
                          else
                            nil
                          end
      notification_type&.with(purchasing_request: @purchasing_request).deliver(manager) if manager.present?

      respond_to do |format|
        format.html { redirect_to @purchasing_request, notice: 'Purchasing request was successfully updated.' }
        format.turbo_stream
      end
    else
      format.html { render :show, status: :unprocessable_entity }
      format.turbo_stream
    end
  end

  def destroy
    @purchasing_request.destroy
    redirect_to purchasing_requests_path, notice: 'PR was successfully destroyed.'
  end

  def request_more_info
    @purchasing_request = PurchasingRequest.find(params[:id])
    if @purchasing_request.update(approval_status: 'pending', note: params[:request_more_info][:message])
      # Send notification to the manager
      manager = User.find_by(position: 'manager')
      PurchaseRequestMoreInfoNeeded.with(purchasing_request: @purchasing_request).deliver_later(manager)
      redirect_to @purchasing_request
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create_note
    @purchasing_request = PurchasingRequest.find(params[:id])
    @note = @purchasing_request.notes.new(note_params)
    @note.user = current_user
    respond_to do |format|
      if @note.save
        format.html { redirect_to @purchasing_request, notice: 'Note was successfully created.' }
        format.turbo_stream
      else
        format.html { render :show, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def create_comment
    @purchasing_request = PurchasingRequest.find(params[:id])
    @comment = @purchasing_request.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      # Send notification
      CommentNotification.with(comment: @comment).deliver(Manager.first)
      redirect_to @purchasing_request, notice: 'Comment was successfully created.'
    else
      # Handle comment creation failure
      render :show, status: :unprocessable_entity
    end
  end

  # def filter_wines
  #   supplier_id = params[:supplier_id]
  #   @wines = Wine.where(supplier_id: supplier_id)
  #   respond_to do |format|
  #     format.html { redirect_to new_purchasing_request_path }
  #     format.turbo_stream
  #   end
  # end

  private

  def more_info_params
    params.require(:more_info).permit(:message)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

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
    params.require(:purchasing_request).permit(:supplier_id, :delivery_date, :delivery_time_slot, :approval_status, :note, purchasing_request_items_attributes: [:id, :wine_id, :quantity])
  end
end
