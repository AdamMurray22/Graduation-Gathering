import 'package:graduation_gathering/Profile/Connections/connection_permission_enum.dart';
import 'package:graduation_gathering/Profile/Connections/other_user_profiles.dart';

import 'connection.dart';

class Connections extends Iterable<Connection>
{
  final Set<Connection> _connections = {};

  Connections(List<dynamic> connections, OtherUserProfiles allOtherUserProfiles)
  {
    for (Map<String, dynamic> connection in connections)
    {
      _connections.add(Connection(allOtherUserProfiles.getUserFromId(connection["toUser"])!, ConnectionPermission.getPermissionFromString(connection["permission"]!)!));
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