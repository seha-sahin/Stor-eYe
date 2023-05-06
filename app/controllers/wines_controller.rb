class WinesController < ApplicationController
  before_action :set_wine, only: %i[show edit update destroy]

  def index
    @wines = params[:search] ? Wine.all.tagged_with(filter_params(params[:search]), any: true) : Wine.all

    if params[:supplier_id].present?
      supplier = Supplier.find(params[:supplier_id])
      @wines = supplier.wines
    end
  end

  def show
  end

  private

  def filter_params(params, queries = [])
    params.each_value do |param|
      queries << param
    end
    queries.flatten.reject(&:blank?)
  end

  def set_wine
    @wine = Wine.find(params[:id])
  end
end
