import 'package:flutter/foundation.dart';

class ModeViewModel extends ChangeNotifier {
  bool isEditing = false;
  int indexToEdit = -1;

  ModeViewModel();

  void setEditingMode(int index) {
    isEditing = true;
    indexToEdit = index;
    notifyListeners();
  }

  void setAddingMode() {
    isEditing = false;
    notifyListeners();
  }
}
