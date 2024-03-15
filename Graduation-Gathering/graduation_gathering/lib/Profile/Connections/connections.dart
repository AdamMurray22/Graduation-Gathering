import 'package:graduation_gathering/Profile/Connections/connection_permission_enum.dart';
import 'package:graduation_gathering/Profile/Connections/connection_type.dart';
import 'package:graduation_gathering/Profile/Connections/other_user_profiles.dart';
import 'package:graduation_gathering/Profile/profile_settings.dart';

import 'connection.dart';

class Connections extends Iterable<Connection>
{
  final Set<Connection> _connections = {};

  Connections(List<dynamic> connections, OtherUserProfiles allOtherUserProfiles, ProfileSettings userProfile)
  {
    Set<String> doneBothIds = {};
    for (Map<String, dynamic> connection in connections)
    {
      if (connection["fromUser"] == userProfile.getId())
      {
        if (!doneBothIds.contains(connection["toUser"])) {
          Map<String, dynamic>? isBoth = isBothFrom(connections, userProfile);
          if (isBoth != null) {
            _connections.add(Connection(
                allOtherUserProfiles.getUserFromId(connection["toUser"])!,
                ConnectionPermission.getPermissionFromString(
                    connection["permission"]!)!, ConnectionPermission.getPermissionFromString(isBoth["permission"])));
            doneBothIds.add(connection["toUser"]);
          }
          else {
            _connections.add(Connection(
                allOtherUserProfiles.getUserFromId(connection["toUser"])!,
                ConnectionPermission.getPermissionFromString(
                    connection["permission"]!)!, null));
          }
        }
      }
      else {
        if (!doneBothIds.contains(connection["fromUser"])) {
        Map<String, dynamic>? isBoth = isBothTo(connections, userProfile);
        if (isBoth != null) {
          _connections.add(Connection(
              allOtherUserProfiles.getUserFromId(connection["fromUser"])!,
              ConnectionPermission.getPermissionFromString(
                  connection["permission"]), ConnectionPermission.getPermissionFromString(isBoth["permission"])));
          doneBothIds.add(connection["fromUser"]);
        }
        else {
          _connections.add(Connection(
              allOtherUserProfiles.getUserFromId(connection["fromUser"])!,
              null,
              ConnectionPermission.getPermissionFromString(
                  connection["permission"])));
        }
      }
      }
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

  Map<String, dynamic>? isBothFrom(List<dynamic> connections, ProfileSettings userProfile)
  {
    for (Map<String, dynamic> connection in connections)
    {
      if (connection["toUser"] == userProfile.getId())
      {
        return connection;
      }
    }
    return null;
  }

  Map<String, dynamic>? isBothTo(List<dynamic> connections, ProfileSettings userProfile)
  {
    for (Map<String, dynamic> connection in connections)
    {
      if (connection["fromUser"] == userProfile.getId())
      {
        return connection;
      }
    }
    return null;
  }
}