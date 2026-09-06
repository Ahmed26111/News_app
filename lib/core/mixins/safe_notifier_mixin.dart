import 'package:flutter/cupertino.dart';

mixin SafeNotifier on ChangeNotifier{
  bool isDisposed = false;

  @override
  void notifyListeners() {
    if(!isDisposed){
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

}