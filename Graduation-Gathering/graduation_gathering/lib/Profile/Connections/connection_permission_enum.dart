enum ConnectionPermission
{
  granted,
  requested,
  denied;

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