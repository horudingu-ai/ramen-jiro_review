function initMapOnPage() {
  const el = document.getElementById("map");
  if (!el) return; // 地図がないページでは何もしない

  // 既に初期化済みなら二重初期化しない（保険）
  if (el.dataset.mapInitialized === "true") return;
  el.dataset.mapInitialized = "true";

  const map = new google.maps.Map(el, {
    center: { lat: 35.6812, lng: 139.7671 },
    zoom: 15,
    // Advanced Marker使うなら mapId 必須
    // mapId: "YOUR_MAP_ID",
  });

  // marker使うならここで
}

document.addEventListener("turbo:load", () => {
  if (window.google?.maps) initMapOnPage();
});
