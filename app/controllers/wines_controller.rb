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

  def new
    @wine = Wine.new
  end

  def create
    @wine = Wine.new(wine_params)
    if @wine.save
      redirect_to wines_path, notice: "Wine was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
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

  def wine_params
    params.require(:wine).permit(:maker, :country, :vintage, :colour, :region, :appellation, :volume, :cuvee, :tasting_notes, :grape_variety, :description, :supplier_id, :unit_price, :avg_price, :selling_price, :quantity, :cost, :restaurant_id, :session_start => [], :session_end => [])
  end
end
