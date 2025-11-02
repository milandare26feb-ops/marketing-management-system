class MapboxConfig {
  // 🗺️ Mapbox Access Token (Secret Key)
  static const String accessToken = 
      'sk.eyJ1IjoibWlsYW5kYXJlMjZmZWIiLCJhIjoiY21oaHFtMTFzMG03czJsczdiMmtuaXV4MiJ9.MnNIZR56khq3BCQB8pmlqw';
  
  // 🎨 Map Style URLs
  static const String styleStreets = 'mapbox://styles/mapbox/streets-v12';
  static const String styleDark = 'mapbox://styles/mapbox/dark-v11';
  static const String styleSatellite = 'mapbox://styles/mapbox/satellite-streets-v12';
  static const String styleOutdoors = 'mapbox://styles/mapbox/outdoors-v12';
  
  // 📍 Default Map Settings
  static const double defaultZoom = 14.0;
  static const double defaultLatitude = 23.8103; // Dhaka, Bangladesh
  static const double defaultLongitude = 90.4125;
}
