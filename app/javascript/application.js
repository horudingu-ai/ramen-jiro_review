// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
window.initMap = function () {
  const el = document.getElementById("map");
  if (!el) return;

  const lat = parseFloat(el.dataset.lat);
  const lng = parseFloat(el.dataset.lng);

  const map = new google.maps.Map(el, {
    center: { lat, lng },
    zoom: 15,
  });

  new google.maps.Marker({ position: { lat, lng }, map });
};

import "@hotwired/turbo-rails"
import "controllers"
import "star_rating"

window.initMap = function () {
  const el = document.getElementById("map");
  if (!el) return;

  const lat = parseFloat(el.dataset.lat);
  const lng = parseFloat(el.dataset.lng);
  if (!Number.isFinite(lat) || !Number.isFinite(lng)) return;

  const map = new google.maps.Map(el, {
    center: { lat, lng },
    zoom: 15,
  });
  new google.maps.Marker({ position: { lat, lng }, map });
};