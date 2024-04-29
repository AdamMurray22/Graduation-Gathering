/// Holds a location.
class Location
{
  final double _latitude;
  final double _longitude;

  /// Constructor for the Location setting the longitude and latitude.
  Location(this._longitude, this._latitude);

  /// Returns the latitude.
  double getLatitude()
  {
    return _latitude;
  }

  /// Returns the longitude.
  double getLongitude()
  {
    return _longitude;
  }

  /// Sets the == operator to check if the longitude and latitude of the two object are equal.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Location &&
              runtimeType == other.runtimeType &&
              _latitude == other._latitude &&
              _longitude == other._longitude;

  /// Sets the hashcode to use the longitude and latitude.
  @override
  int get hashCode => _longitude.hashCode + _latitude.hashCode;
}