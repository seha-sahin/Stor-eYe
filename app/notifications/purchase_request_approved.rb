# To deliver this notification:
#
# PurchaseRequestApproved.with(post: @post).deliver_later(current_user)
# PurchaseRequestApproved.with(post: @post).deliver(current_user)

class PurchaseRequestApproved < Noticed::Base
  # Add your delivery methods
  #
  # deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end
  #
  # def url
  #   post_path(params[:post])
  # end
  deliver_by :database
  param :purchasing_request

  def message
    "Purchase request #{params[:purchasing_request].id} has been approved."
  end

  def url
    Rails.application.routes.url_helpers.purchasing_request_path(params[:purchasing_request])
  end
end
