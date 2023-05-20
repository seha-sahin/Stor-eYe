class WinesController < ApplicationController
  before_action :set_wine, only: %i[show edit update destroy]

  def index
    @wines = filter_wines
    @search_params = params[:search] || {}
    geocoded_wines = geocoded_items(@wines)
    @markers = add_markers(geocoded_wines)
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

  def edit
    @wine = Wine.find(params[:id])
  end

  def update
    @wine = Wine.find(params[:id])

    if @wine.update(wine_params)
      redirect_to @wine
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    wine = Wine.find(params[:id])
    wine.destroy

    redirect_to wines_path
  end

  private

  def geocoded_items(items)
    items.select do |item|
      item.latitude.present? && item.longitude.present?
    end
  end

  def add_markers(items)
    items.map do |item|
      {
        lat: item.latitude,
        lng: item.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { wine: item }),
        marker_html: render_to_string(partial: "marker", locals: { wine: item })
      }
    end
  end

  def filter_by_search_query
    params[:query].present? ? Wine.wine_search(params[:query]) : Wine.all
  end

  def filter_wines
    wines = filter_by_search_query
    search_params = params[:search] || {}
    filters = %i[makers vintages countries regions]
    filters.each do |filter|
      wines = wines.tagged_with(search_params[filter], any: true) if search_params[filter].present?
    end

    return wines
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
    params.require(:wine).permit(:maker, :country, :vintage, :colour, :region, :appellation, :volume, :cuvee, :tasting_notes, :grape_variety, :description, :supplier_id, :unit_price, :avg_price, :selling_price, :quantity, :address, :cost, :restaurant_id, :photo, :session_start => [], :session_end => [])
  end
end
