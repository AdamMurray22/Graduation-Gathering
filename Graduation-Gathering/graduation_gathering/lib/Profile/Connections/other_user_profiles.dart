import 'connection_profile.dart';

/// Collection of the other users profiles.
class OtherUserProfiles extends Iterable<ConnectionProfile>
{
  final List<ConnectionProfile> _connectionProfile = [];

  OtherUserProfiles(List<dynamic> profiles)
  {
    for (Map<String, dynamic> user in profiles)
    {
      _connectionProfile.add(ConnectionProfile(user["userID"], user["userEmail"], user["accountType"], user["userName"], user["faculty"], user["school"], user["course"]));
    }
  }

  /// Returns the user profile from the given user Id.
  ConnectionProfile? getUserFromId(String id)
  {
    for (ConnectionProfile profile in _connectionProfile)
    {
      if (profile.getId() == id)
      {
        return profile;
      }
    }
    return null;
  }
  /// Returns an iterable of the collection of profiles.
  @override
  Iterator<ConnectionProfile> get iterator => _connectionProfile.iterator;
}