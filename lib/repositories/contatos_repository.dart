import 'package:agenda_connect/models/contato_model.dart';
import 'package:flutter/material.dart';

import 'back_4app_repository.dart';
import 'impl/http_back4app_repository.dart';

class ContatoRepository extends ChangeNotifier {
  List<ContatoModel> contatos = <ContatoModel>[];
  final Back4AppRepository _httpRepository = HttpBack4AppRepository();
  carregarContatos(String status) async {
    contatos = await _httpRepository.obterContatoCadastrado(status);
    notifyListeners();
  }

  adicionar(ContatoModel contatoModel) async {
    await _httpRepository.cadastrarContato(contatoModel);
    contatos = await _httpRepository.obterContatoCadastrado("");
    notifyListeners();
  }

  alterar(String id, ContatoModel contatoModel, {String? status}) async {
    await _httpRepository.atualizarContato(contatoModel, id);
    //contatos = await _httpRepository.obterContatoCadastrado(status ?? "");
    notifyListeners();
  }

  remover(String id) async {
    await _httpRepository.deletarContato(id);
    contatos = await _httpRepository.obterContatoCadastrado("");
    notifyListeners();
  }
}
