import 'package:flutter/cupertino.dart';

class WalkthroughViewModel extends ChangeNotifier {
  int currentIndex = 0;

  void nextPage(PageController controller) {
    if (currentIndex < 2) {
      currentIndex++;
      controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      notifyListeners();
    }
  }
}