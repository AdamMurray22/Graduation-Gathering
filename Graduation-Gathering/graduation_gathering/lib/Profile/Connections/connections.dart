import 'package:graduation_gathering/Profile/Connections/connection_permission_enum.dart';
import 'package:graduation_gathering/Profile/Connections/connection_profile.dart';
import 'package:graduation_gathering/Profile/Connections/connection_type.dart';
import 'package:graduation_gathering/Profile/Connections/other_user_profiles.dart';
import 'package:graduation_gathering/Profile/profile_settings.dart';

import 'connection.dart';

/// Collection of all the Connections between this user and other users.
class Connections extends Iterable<Connection>
{
  final Set<Connection> _connections = {};

  Connections(List<dynamic> connections, OtherUserProfiles allOtherUserProfiles, ProfileSettings userProfile)
  {
    Map<String, Map<String, String>> transformedConnections = {};
    // Transforms the connections from the format User A, User B, permission (I.e. granted or requested)
    // into the format, User that is not this client user, permission from this
    // user to that user, permission to this user from that user.
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
  }

  /// Adds the given connections to this collection of connections.
  addAll(Connections connections)
  {
    _connections.addAll(connections);
  }

  /// Clears this collection.
  clear()
  {
    _connections.clear();
  }

  /// Creates an iterator from this collection of the connections.
  @override
  Iterator<Connection> get iterator => _connections.iterator;
}