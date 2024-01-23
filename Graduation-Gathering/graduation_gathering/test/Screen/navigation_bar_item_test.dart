import 'package:graduation_gathering/Screen/navigation_bar_items.dart';
import 'package:test/test.dart';

void main() {
  group('Navigation Bar Item Tests', () {

    test('.getSelectedIndex() default value', () {
      NavigationBarItems navigationBarItems = NavigationBarItems();
      expect(navigationBarItems.getSelectedIndex(), 0);
    });

    test('.getSelectedIndex() value changed', () {
      NavigationBarItems navigationBarItems = NavigationBarItems();
      navigationBarItems.setSelectedIndex(3);
      expect(navigationBarItems.getSelectedIndex(), 3);
    });

    test('.getValuesInOrder() default nav bar items', () {
      NavigationBarItems navigationBarItems = NavigationBarItems();
      expect(navigationBarItems.getValuesInOrder(), [
        navigationBarItems.mapScreen,
        navigationBarItems.aboutScreen
      ]);
    });

    test('.getValuesInOrder() default nav bar items', () {
      NavigationBarItems navigationBarItems = NavigationBarItems();
      expect(navigationBarItems.getScreensInOrder(), [
        navigationBarItems.mapScreen.item2,
        navigationBarItems.aboutScreen.item2
      ]);
    });
  });
}