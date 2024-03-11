import 'package:flutter/material.dart';
import 'package:graduation_gathering/Map/Zones/grad_zones.dart';
import 'package:graduation_gathering/Profile/academic_structure.dart';
import 'package:graduation_gathering/Profile/profile_settings.dart';
import 'package:tuple/tuple.dart';

import '../Auth/auth_token.dart';
import 'navigation_bar_items.dart';

/// This holds the screen for the application.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.authToken, required this.profile, required this.academicStructure, required this.gradZones});

  final AuthToken authToken;
  final ProfileSettings profile;
  final AcademicStructure academicStructure;
  final GradZones gradZones;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

// This class contains the GUI structure for the app.
class _MainScreenState extends State<MainScreen> {

  late final NavigationBarItems _navigationBarItems;

  /// Creates the screens accessed through the nav bar.
  @override
  initState() {
    _navigationBarItems = NavigationBarItems(widget.authToken, widget.profile, widget.academicStructure, widget.gradZones);
    if (!widget.profile.getHasLoggedInBefore())
    {
      _navigationBarItems.setSelectedIndex(_navigationBarItems.profileScreen.item1.position);
    }
    super.initState();
  }

  /// Builds the GUI and places the map inside.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff621360),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "Graduation Gathering",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: const Color(0x1f000000),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.zero,
          border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
        ),
        child: IndexedStack(
            index: _navigationBarItems.getSelectedIndex(), children: _navigationBarItems.getScreensInOrder()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _addItemsToBottomNavigationBar(),
        currentIndex: _navigationBarItems.getSelectedIndex(),
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(() {
            _navigationBarItems.setSelectedIndex(index);
          });
        },
      ),
    );
  }

  // Returns the navigation bar items in order.
  List<BottomNavigationBarItem> _addItemsToBottomNavigationBar() {
    List<BottomNavigationBarItem> navBarItems = [];
    for (Tuple2<NavigationBarItemEnum, StatefulWidget> item in _navigationBarItems.getValuesInOrder()) {
      navBarItems.add(BottomNavigationBarItem(
        icon: item.item1.icon,
        label: item.item1.label,
      ));
    }
    return navBarItems;
  }
}