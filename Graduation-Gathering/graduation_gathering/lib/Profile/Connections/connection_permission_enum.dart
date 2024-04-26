/// Permission enums to establish connection types.
enum ConnectionPermission
{
  granted,
  requested,
  denied;

  /// Returns the permission enum from a given string.
  static ConnectionPermission? getPermissionFromString(String? permission)
  {
    if (permission == null)
    {
      return null;
    }
    for (ConnectionPermission value in ConnectionPermission.values)
    {
      if (value.name == permission.toLowerCase())
      {
        return value;
      }
    }
    return null;
  }
}