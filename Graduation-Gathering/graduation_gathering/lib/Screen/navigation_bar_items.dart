import 'package:flutter/material.dart';
import 'package:graduation_gathering/Map/Zones/grad_zones.dart';
import 'package:graduation_gathering/Map/main_map_widget.dart';
import 'package:graduation_gathering/Profile/academic_structure.dart';
import 'package:graduation_gathering/Profile/profile_settings.dart';
import 'package:graduation_gathering/Screen/profile_screen.dart';
import 'package:graduation_gathering/Auth/auth_token.dart';
import 'package:tuple/tuple.dart';

import '../Map/Zones/grad_zone.dart';
import '../Map/Zones/zone_colours_enum.dart';
import 'about_screen.dart';
import 'map_screen.dart';


/// Defines the different screens for the navigation bar.
class NavigationBarItems
{
  final List<Tuple2<NavigationBarItemEnum, StatefulWidget>> _itemsInOrder = [];
  late final Tuple2<NavigationBarItemEnum, MapScreen> mapScreen;
  late final Tuple2<NavigationBarItemEnum, ProfileScreen> profileScreen;
  late final Tuple2<NavigationBarItemEnum, AboutScreen> aboutScreen;

  GlobalKey<MainMapWidgetState> mainMapWidgetStateKey = GlobalKey();

  NavigationBarItems(AuthToken authToken, ProfileSettings profile, AcademicStructure structure, GradZones zones)
  {
    for (GradZone zone in profile.getUserGradZones())
    {
      zones.getZoneFromId(zone.getId())?.setColour(ZoneColours.blue.getColourRGB());
    }
    mapScreen = Tuple2(NavigationBarItemEnum.mapScreen, MapScreen(authToken: authToken, allGradZones: zones, usersGradZones: profile.getUserGradZones(), mainMapWidgetStateKey: mainMapWidgetStateKey));
    profileScreen = Tuple2(NavigationBarItemEnum.profileScreen, ProfileScreen(authToken: authToken, profile: profile, academicStructure: structure, allGradZones: zones, mainMapWidgetStateKey: mainMapWidgetStateKey));
    aboutScreen =
      const Tuple2(NavigationBarItemEnum.aboutScreen, AboutScreen());
    _itemsInOrder.add(mapScreen);
    _itemsInOrder.add(profileScreen);
    _itemsInOrder.add(aboutScreen);
  }

  int _selectedIndexBottomNavBar = 0;

  /// Returns the selected index in the nav bar.
  int getSelectedIndex()
  {
    return _selectedIndexBottomNavBar;
  }

  /// Sets the selected index in the nav bar.
  setSelectedIndex(int index)
  {
    _selectedIndexBottomNavBar = index;
  }

  /// Returns the enums in the order of the navigation bar.
  List<Tuple2<NavigationBarItemEnum, StatefulWidget>> getValuesInOrder() {
    return _itemsInOrder;
  }

  /// Returns the screens in order.
  List<Widget> getScreensInOrder()
  {
    List<Widget> screens = [];
    for (Tuple2<NavigationBarItemEnum, StatefulWidget> barItem in getValuesInOrder())
    {
      screens.add(barItem.item2);
    }
    return screens;
  }
}
enum NavigationBarItemEnum {
  mapScreen(0, Icon(Icons.home), "Home"),
  profileScreen(1, Icon(Icons.settings), "Profile"),
  aboutScreen(2, Icon(Icons.info_outline), "About");

  const NavigationBarItemEnum(this.position, this.icon, this.label);

  final int position; // The position in the nav bar, starting from 0.
  final Icon icon;
  final String label;
}
