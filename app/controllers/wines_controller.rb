class WinesController < ApplicationController
  before_action :set_wine, only: %i[show edit update destroy]

  def index
    @wines = filter_wines

    # respond_to do |format|
    #   format.html
    #   format.json { render json: @wines }
    # end

  end

  def show
  end

  def new
    @wine = Wine.new
  end

  def create
    @wine = Wine.new(wine_params)
    if @wine.save
      update_tags(@wine)
      redirect_to wines_path, notice: "Wine was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def text_search
    params[:query].present? ? Wine.wine_search(params[:query]) : Wine.all
  end

  def filter_wines
    wines = text_search
    params[:search] ? wines.tagged_with(filter_params(params[:search]), any: true) : wines
  end

  def update_tags(wine)
    wine.update(
      maker_list: wine.maker,
      country_list: wine.country,
      vintage_list: wine.vintage,
      region_list: wine.region,
      appellation_list: wine.appellation,
      cuvee_list: wine.cuvee
    )
  end

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
    params.require(:wine).permit(:maker, :country, :vintage, :colour, :region, :appellation, :volume, :cuvee,
      :tasting_notes, :grape_variety, :description, :supplier_id, :unit_price, :avg_price, :selling_price,
      :quantity, :cost, :restaurant_id, :session_start => [], :session_end => [])
  end
end
