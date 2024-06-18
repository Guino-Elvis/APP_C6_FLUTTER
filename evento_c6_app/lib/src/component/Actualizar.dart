import 'package:flutter/material.dart';

class Actualizar extends ChangeNotifier {
  List<dynamic> _data = [];

  List<dynamic> get data => _data;

  void setData(List<dynamic> newData) {
    _data = newData;
    notifyListeners();
  }

  // Agrega métodos para agregar, eliminar u otros cambios en la lista de usuarios
}