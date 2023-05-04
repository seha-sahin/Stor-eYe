class WinesController < ApplicationController
  before_action :set_wine, only: %i[show edit update destroy]

  def index
    @wines = Wine.all
  end

  def show
  end

  private

  def set_wine
    @wine = Wine.find(params[:id])
  end
end
