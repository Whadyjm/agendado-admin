import 'package:flutter/foundation.dart';

class SideBarMenuItemState with ChangeNotifier{
  bool _activeDashboard = true;
  bool _activeCanchas = false;
  bool _activePerfil = false;
  bool _activePagos = false;

  bool get activeDashboard => _activeDashboard;
  bool get activeCanchas => _activeCanchas;
  bool get activePerfil => _activePerfil;
  bool get activePagos => _activePagos;

  void active1(){
    _activeDashboard = !_activeDashboard;
    notifyListeners();
  }

  void active2(){
    _activeCanchas = !_activeCanchas;
    notifyListeners();
  }
}