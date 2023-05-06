class WinesController < ApplicationController
  before_action :set_wine, only: %i[show edit update destroy]

  def index
    supplier = Supplier.find(params[:supplier_id])
    @wines = supplier.wines
    respond_to do |format|
      format.js
    end
  end

  def show
  end

  private

  def set_wine
    @wine = Wine.find(params[:id])
  end
end
