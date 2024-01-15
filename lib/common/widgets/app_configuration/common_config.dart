import 'package:flutter/cupertino.dart';

class CommonConfig extends ChangeNotifier {
  bool isMute = false;
  bool isAutoPlay = false;

  bool isDarkMode = false;

  void toggleIsMuted() {
    isMute = !isMute;
    notifyListeners();
  }

  void toggleAutoPlay() {
    isAutoPlay = !isAutoPlay;
    notifyListeners();
  }

  void toggleMode() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}