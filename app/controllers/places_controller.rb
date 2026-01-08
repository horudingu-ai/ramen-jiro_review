class PlacesController < ApplicationController
  def index
    @places = Place.all
    @markers = @places.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        info_window: render_to_string(partial: "info_window", locals: { place: place }),
        image_url: helpers.asset_url("marker.png")
      }
    end
  end
end