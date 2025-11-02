import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
  State<MapboxMapView> createState() => MapboxMapViewState();
}

class MapboxMapViewState extends State<MapboxMapView> {
  final MapController _mapController = MapController();
  final List<Marker> _markers = [];

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: LatLng(
          widget.initialLatitude ?? MapboxConfig.defaultLatitude,
          widget.initialLongitude ?? MapboxConfig.defaultLongitude,
        ),
        initialZoom: widget.initialZoom ?? MapboxConfig.defaultZoom,
        onTap: _onMapTap,
        onLongPress: _onMapLongPress,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/{z}/{x}/{y}?access_token=${MapboxConfig.accessToken}',
          userAgentPackageName: 'com.confidencefeed.markettrack',
          tileSize: 512,
          zoomOffset: -1,
        ),
        MarkerLayer(
          markers: _markers,
        ),
      ],
    );
  }

  void _onMapTap(TapPosition tapPosition, LatLng latLng) {
    if (widget.onMapClick != null) {
      widget.onMapClick!(latLng.latitude, latLng.longitude);
    }
  }

  void _onMapLongPress(TapPosition tapPosition, LatLng latLng) {
    if (widget.onMapLongClick != null) {
      widget.onMapLongClick!(latLng.latitude, latLng.longitude);
    }
  }
  
  /// Add marker to map
  Future<void> addMarker(double lat, double lng, {String? title}) async {
    setState(() {
      _markers.add(
        Marker(
          point: LatLng(lat, lng),
          width: 40,
          height: 40,
          child: Icon(
            Icons.location_on,
            color: Color(0xFF2E5BFF),
            size: 40,
          ),
        ),
      );
    });
    print('✅ Marker added at: $lat, $lng');
  }
  
  /// Move camera to location
  Future<void> moveCamera(double lat, double lng, {double? zoom}) async {
    _mapController.move(
      LatLng(lat, lng),
      zoom ?? MapboxConfig.defaultZoom,
    );
  }
}
