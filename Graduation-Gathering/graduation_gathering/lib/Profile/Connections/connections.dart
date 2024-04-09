import 'package:graduation_gathering/Profile/Connections/connection_permission_enum.dart';
import 'package:graduation_gathering/Profile/Connections/connection_profile.dart';
import 'package:graduation_gathering/Profile/Connections/connection_type.dart';
import 'package:graduation_gathering/Profile/Connections/other_user_profiles.dart';
import 'package:graduation_gathering/Profile/profile_settings.dart';

import 'connection.dart';

class Connections extends Iterable<Connection>
{
  final Set<Connection> _connections = {};

  Connections(List<dynamic> connections, OtherUserProfiles allOtherUserProfiles, ProfileSettings userProfile)
  {
    Map<String, Map<String, String>> transformedConnections = {};
    for (Map<String, dynamic> connection in connections)
    {
      if (connection["fromUser"] == userProfile.getId())
      {
        String otherUser = connection["toUser"];
        if (transformedConnections[otherUser] == null)
        {
          transformedConnections[otherUser] = {"toUser": connection["permission"]};
        }
        else
        {
          transformedConnections[otherUser]!["toUser"] = connection["permission"];
        }
      }
      else if (connection["toUser"] == userProfile.getId())
      {
        String otherUser = connection["fromUser"];
        if (transformedConnections[otherUser] == null)
        {
          transformedConnections[otherUser] = {"fromUser": connection["permission"]};
        }
        else
        {
          transformedConnections[otherUser]!["fromUser"] = connection["permission"];
        }
      }
    }

    transformedConnections.forEach((key, value)
    {
      _connections.add(Connection(allOtherUserProfiles.getUserFromId(key)!, ConnectionPermission.getPermissionFromString(value["toUser"]), ConnectionPermission.getPermissionFromString(value["fromUser"])));
    });
    print(_connections);
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