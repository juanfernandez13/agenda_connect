import 'package:flutter/material.dart';
import 'dart:math';

class ContatoModel extends ChangeNotifier {
  String _id = UniqueKey().toString();
  String _nome = "";
  String _path = "";
  String _telefone = "";
  String _email = "";
  String _funcao = "";
  bool _favorito = false;
  bool _emergencia = false;
  int _colorR = 0;
  int _colorG = 0;
  int _colorB = 0;

  ContatoModel();

  String get id => _id;
  String get nome => _nome;
  String get telefone => _telefone;
  String get path => _path;
  String get email => _nome;
  String get funcao => _funcao;
  bool get favorito => _favorito;
  bool get emergencia => _emergencia;
  int get colorR => _colorR;
  int get colorG => _colorG;
  int get colorB => _colorB;

  set id(String value) {
    _id = value;
    notifyListeners();
    }
  set nome(String value) {
    _nome = value;
    notifyListeners();
    }
  set telefone(String value) {
    _telefone = value;
    notifyListeners();
    }
  set email(String value) {
    _email = value;
    notifyListeners();
    }
  set path(String value) {
    _path = value;
    notifyListeners();
    }
  set funcao(String value) {
    _funcao = value;
    notifyListeners();
    }
  set favorito(bool value) {
    _favorito = value;
    notifyListeners();
    }
  set emergencia(bool value) {
    _emergencia = value;
    notifyListeners();
    }
  set colorR(int value) {
    _colorR = value;
    notifyListeners();
    }
  set colorG(int value) {
    _colorG = value;
    notifyListeners();
    }
  set colorB(int value) {
    _colorB = value;
    notifyListeners();
    }

  ContatoModel.fromJson(Map<String, dynamic> json) {
    _id = json['objectId'];
    _nome = json['nome'];
    _path = json['path'];
    _telefone = json['telefone'];
    _email = json['email'];
    _funcao = json['funcao'];
    _favorito = json['favorito'];
    _emergencia = json['emergencia'];
    _colorR = json['colorR'];
    _colorG = json['colorG'];
    _colorB = json['colorB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = _nome;
    data['path'] = _path;
    data['telefone'] = _telefone;
    data['email'] = _email;
    data['funcao'] = _funcao;
    data['favorito'] = _favorito;
    data['emergencia'] = _emergencia;
    data['colorR'] = _colorR;
    data['colorG'] = _colorG;
    data['colorB'] = _colorB;
    return data;
  }

  Color gerarCor() {
    while ((_colorR + _colorG + _colorB) < 450 &&
        (_colorR + _colorG + _colorB) == 0) {
      _colorR = Random().nextInt(255);
      _colorG = Random().nextInt(255);
      _colorB = Random().nextInt(255);
    }

    return Color.fromARGB(255, _colorR, _colorG, _colorB);
  }
}
