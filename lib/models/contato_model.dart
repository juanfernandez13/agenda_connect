import 'package:flutter/material.dart';
import 'dart:math';

class ContatoModel {
  String nome = "";
  String path = "";
  String telefone = "";
  String email = "";
  String funcao = "";
  bool favorito = false;
  bool emergencia = false;
  int colorR = 0;
  int colorG = 0;
  int colorB = 0;

  ContatoModel(
      {required this.nome,
      required this.path,
      required this.telefone,
      required this.email,
      required this.funcao,
      required this.favorito,
      required this.emergencia,
      required this.colorR,
      required this.colorG,
      required this.colorB});

  ContatoModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    path = json['path'];
    telefone = json['telefone'];
    email = json['email'];
    funcao = json['funcao'];
    favorito = json['favorito'];
    emergencia = json['emergencia'];
    colorR = json['colorR'];
    colorG = json['colorG'];
    colorB = json['colorB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['path'] = this.path;
    data['telefone'] = this.telefone;
    data['email'] = this.email;
    data['funcao'] = this.funcao;
    data['favorito'] = this.favorito;
    data['emergencia'] = this.emergencia;
    data['colorR'] = this.colorR;
    data['colorG'] = this.colorG;
    data['colorB'] = this.colorB;
    return data;
  }

  static Color gerarCor(int R, int G, int B) {
    while (R + G + B > 450) {
      R = Random().nextInt(255);
      G = Random().nextInt(255);
      B = Random().nextInt(255);
    }
    return Color.fromARGB(255, R, G, B);
  }
}
