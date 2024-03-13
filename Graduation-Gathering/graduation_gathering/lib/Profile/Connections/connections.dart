import 'package:graduation_gathering/Profile/Connections/connection_permission_enum.dart';

import 'connection.dart';

class Connections extends Iterable<Connection>
{
  final Set<Connection> _connections = {};

  Connections(List<dynamic> connections)
  {
    for (Map<String, dynamic> connection in connections)
    {
      _connections.add(Connection(connection["toUser"]!, ConnectionPermission.getPermissionFromString(connection["permission"]!)!));
    }
  }

  addAll(Connections connections)
  {
    _connections.addAll(connections);
  }

  clear()
  {
    _connections.clear();
  }

  @override
  Iterator<Connection> get iterator => _connections.iterator;
}