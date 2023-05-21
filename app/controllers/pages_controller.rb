class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @markers = add_markers(Wine.geocoded)
  end

  private

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
end
