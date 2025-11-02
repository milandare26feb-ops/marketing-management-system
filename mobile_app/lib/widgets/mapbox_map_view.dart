import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../core/mapbox_config.dart';

class MapboxMapView extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;
  final double? initialZoom;
  final Function(double lat, double lng)? onMapClick;
  final Function(double lat, double lng)? onMapLongClick;
  
  const MapboxMapView({
    Key? key,
    this.initialLatitude,
    this.initialLongitude,
    this.initialZoom,
    this.onMapClick,
    this.onMapLongClick,
  }) : super(key: key);

  @override
  State<MapboxMapView> createState() => _MapboxMapViewState();
}

class _MapboxMapViewState extends State<MapboxMapView> {
  MapboxMap? _mapboxMap;

  @override
  Widget build(BuildContext context) {
    return MapWidget(
      key: ValueKey("mapWidget"),
      resourceOptions: ResourceOptions(
        accessToken: MapboxConfig.accessToken,
      ),
      cameraOptions: CameraOptions(
        center: Point(
          coordinates: Position(
            widget.initialLongitude ?? MapboxConfig.defaultLongitude,
            widget.initialLatitude ?? MapboxConfig.defaultLatitude,
          ),
        ),
        zoom: widget.initialZoom ?? MapboxConfig.defaultZoom,
      ),
      styleUri: MapboxConfig.styleStreets,
      onMapCreated: _onMapCreated,
      onTapListener: _onMapTap,
      onLongTapListener: _onMapLongTap,
    );
  }

  void _onMapCreated(MapboxMap mapboxMap) {
    _mapboxMap = mapboxMap;
    print('✅ Mapbox Map Created');
  }

  void _onMapTap(ScreenCoordinate coordinate) async {
    if (widget.onMapClick != null && _mapboxMap != null) {
      final point = await _mapboxMap!.coordinateForPixel(coordinate);
      widget.onMapClick!(
        point.coordinates.lat,
        point.coordinates.lng,
      );
    }
  }

  void _onMapLongTap(ScreenCoordinate coordinate) async {
    if (widget.onMapLongClick != null && _mapboxMap != null) {
      final point = await _mapboxMap!.coordinateForPixel(coordinate);
      widget.onMapLongClick!(
        point.coordinates.lat,
        point.coordinates.lng,
      );
    }
  }
  
  /// Add marker to map
  Future<void> addMarker(double lat, double lng, {String? title}) async {
    if (_mapboxMap == null) return;
    
    // Add point annotation
    final pointAnnotationManager = await _mapboxMap!.annotations.createPointAnnotationManager();
    
    final pointAnnotation = PointAnnotationOptions(
      geometry: Point(coordinates: Position(lng, lat)),
      iconImage: "marker-15", // Default Mapbox marker
    );
    
    await pointAnnotationManager.create(pointAnnotation);
    print('✅ Marker added at: $lat, $lng');
  }
  
  /// Move camera to location
  Future<void> moveCamera(double lat, double lng, {double? zoom}) async {
    if (_mapboxMap == null) return;
    
    await _mapboxMap!.flyTo(
      CameraOptions(
        center: Point(coordinates: Position(lng, lat)),
        zoom: zoom ?? MapboxConfig.defaultZoom,
      ),
      MapAnimationOptions(duration: 1000),
    );
  }
}
