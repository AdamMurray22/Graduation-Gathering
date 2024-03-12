import 'package:graduation_gathering/Auth/auth_token.dart';
import 'package:graduation_gathering/Map/Zones/grad_zones.dart';
import 'package:graduation_gathering/Profile/academic_structure.dart';
import 'package:graduation_gathering/Profile/profile_settings.dart';
import 'package:graduation_gathering/Screen/navigation_bar_items.dart';
import 'package:test/test.dart';

void main() {
  group('Navigation Bar Item Tests', () {

    AuthToken authToken = AuthToken("");
    GradZones zones = GradZones([]);
    ProfileSettings profile = ProfileSettings(true, "", "", "Student", null, null, null, null, zones);
    AcademicStructure structure = AcademicStructure({});

    test('.getSelectedIndex() default value', () {
      NavigationBarItems navigationBarItems = NavigationBarItems(authToken, profile, structure, zones);
      expect(navigationBarItems.getSelectedIndex(), 0);
    });

    test('.getSelectedIndex() value changed', () {
      NavigationBarItems navigationBarItems = NavigationBarItems(authToken, profile, structure, zones);
      navigationBarItems.setSelectedIndex(3);
      expect(navigationBarItems.getSelectedIndex(), 3);
    });

    test('.getValuesInOrder() default nav bar items', () {
      NavigationBarItems navigationBarItems = NavigationBarItems(authToken, profile, structure, zones);
      expect(navigationBarItems.getValuesInOrder(), [
        navigationBarItems.mapScreen,
        navigationBarItems.profileScreen,
        navigationBarItems.aboutScreen
      ]);
    });

    test('.getValuesInOrder() default nav bar items', () {
      NavigationBarItems navigationBarItems = NavigationBarItems(authToken, profile, structure, zones);
      expect(navigationBarItems.getScreensInOrder(), [
        navigationBarItems.mapScreen.item2,
        navigationBarItems.profileScreen.item2,
        navigationBarItems.aboutScreen.item2
      ]);
    });
  });
}