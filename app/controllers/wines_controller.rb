class WinesController < ApplicationController
  before_action :set_wine, only: %i[show edit update destroy]

  def index
    if params[:supplier_id].present?
      supplier = Supplier.find(params[:supplier_id])
      @wines = supplier.wines
    else
      @wines = Wine.all
    end
  end

  def show
  end

  private

  def set_wine
    @wine = Wine.find(params[:id])
  end
end
