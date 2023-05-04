class StorageLocationsController < ApplicationController
  before_action :set_storage_location, only: [:show, :edit, :update, :destroy]

  def index
    @storage_locations = StorageLocation.all
  end

  def show
  end

  def new
    @storage_location = StorageLocation.new
  end

  def edit
  end

  def create
    @storage_location = StorageLocation.new(storage_location_params)

    if @storage_location.save
      redirect_to storage_locations_path, notice: 'Storage location was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @storage_location.update(storage_location_params)
      redirect_to @storage_location, notice: 'Storage location was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @storage_location.destroy
    redirect_to storage_locations_url, notice: 'Storage location was successfully destroyed.'
  end

  private

  def set_storage_location
    @storage_location = StorageLocation.find(params[:id])
  end

  def storage_location_params
    params.require(:storage_location).permit(:name, :address, :capacity, :temperature, :restaurant_id)
  end
end
