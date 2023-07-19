import 'package:flutter/material.dart';

import '../screens/addAgent/addAgentScreen.dart';
import '../screens/addMall/addMallScreen.dart';
import '../screens/addStores/addStoresScreen.dart';
import '../screens/dashboard/dashboard_screen.dart';

class DrawerScreenProvider extends ChangeNotifier {
  late Widget _currentScreen = DashboardScreen();
  Widget get currentScreen => _currentScreen;
  set currentScreen(Widget newScreen) {
    _currentScreen = newScreen;
    notifyListeners();
  }

  void changeCurrentScreen(CustomScreensEnum screen) {
    switch (screen) {
      case CustomScreensEnum.dashboard:
        currentScreen = DashboardScreen();
        break;
      case CustomScreensEnum.addStore:
        currentScreen = const AddStoreScreen();
        break;
      case CustomScreensEnum.addAgent:
        currentScreen = const AddAgentScreen();
        break;
      case CustomScreensEnum.addMall:
        currentScreen = const AddMallScreen();
        break;
      default:
        currentScreen = DashboardScreen();
        break;
    }
  }
}

enum CustomScreensEnum { dashboard, addStore, addAgent, addMall }
