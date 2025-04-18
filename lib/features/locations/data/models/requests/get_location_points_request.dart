class GetLocationPointsRequest {
  double longitude;
  double latitude;
  double radius;
  int zoomLevel;
  
  GetLocationPointsRequest({this.longitude=0,
  this.latitude=0,
  this.radius=0,
  this.zoomLevel=0});

  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
      'radius': radius,
      'zoomLevel': zoomLevel,
    };
  }
}
