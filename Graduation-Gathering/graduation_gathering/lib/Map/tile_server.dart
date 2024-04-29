/// Defines a tile server from which the map should be retrieved.
class TileServer
{
  final String _url;
  final String _attribution;

  TileServer(this._url, this._attribution);

  /// Returns the server url.
  String get url => _url;

  /// Returns the attribution for the server.
  String get attribution => _attribution;

  /// Returns the domain for the server.
  String? getUrlDomains()
  {
    try {
      return url.split("/")[2];
    } catch (e)
    {
      return null;
    }
  }
}