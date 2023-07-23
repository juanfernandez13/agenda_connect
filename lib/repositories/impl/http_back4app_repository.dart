import 'package:agenda_connect/models/contato_model.dart';
import 'package:agenda_connect/repositories/back_4app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpBack4AppRepository implements Back4AppRepository {
  final baseUrl = dotenv.get("BASE_URL_BACK4APP");
  Map<String, String> headers = {
    "X-Parse-Application-Id": dotenv.get("X_PARSE_APPLICATION_ID"),
    "X-Parse-Rest-API-Key": dotenv.get("X_PARSE_REST_API_KEY"),
    //"Content-Type": dotenv.get("CONTENT_TYPE"),
  };

  @override
  Future<List<ContatoModel>> obterContatoCadastrado(String status) async {
    var response =
        await http.get(Uri.parse("$baseUrl/contatos"), headers: headers);
    var responseDecode = json.decode(response.body);
    if (response.statusCode == 200) {
      return (responseDecode["results"] as List)
          .map((e) => ContatoModel.fromJson(e))
          .toList();
    }
    return <ContatoModel>[];
  }

  @override
  Future<void> cadastrarContato(ContatoModel contatoModel) async {
    http.Response response = await http.post(Uri.parse("$baseUrl/contatos"),
        headers: headers, body: jsonEncode(contatoModel.toJson()));
    debugPrint(response.statusCode.toString());
  }

  @override
  Future<void> atualizarContato(ContatoModel contatoModel, String id) async {
    try {
      http.Response response = await http.put(
          Uri.parse("$baseUrl/contatos/$id"),
          headers: headers,
          body: json.encode({
            'nome': contatoModel.nome,
            'telefone': contatoModel.telefone,
            'email': contatoModel.email,
            'funcao': contatoModel.funcao,
            'colorR': contatoModel.colorR,
            'colorG': contatoModel.colorG,
            'colorB': contatoModel.colorB,
            'favorito': contatoModel.favorito,
            'emergencia': contatoModel.emergencia
          }));
      debugPrint(response.statusCode.toString());
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  Future<void> deletarContato(String id) async {
    http.Response response =
        await http.delete(Uri.parse("$baseUrl/contatos/$id"), headers: headers);
    debugPrint(response.statusCode.toString());
  }
}
