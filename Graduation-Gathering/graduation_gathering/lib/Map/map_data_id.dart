import '../Exceptions/map_data_id_not_found_exception.dart';

/// Defines the ids for the map layers.
enum MapDataId
{
  userLocation("UL-"),
  otherUsers("OU-");

  const MapDataId(this.idPrefix);
  final String idPrefix;

  /// Returns the MapDataId enum that corresponds to the given id.
  static MapDataId getMapDataIdEnumFromId(String id)
  {
    for (MapDataId mapDataId in MapDataId.values)
    {
      if (id.startsWith(mapDataId.idPrefix))
      {
        return mapDataId;
      }
    }
    throw MapDataIdNotFoundException("Id not found.");
  }
}