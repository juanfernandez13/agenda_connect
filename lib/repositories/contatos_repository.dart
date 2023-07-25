import 'package:agenda_connect/models/contato_model.dart';
import 'package:flutter/material.dart';

import 'back_4app_repository.dart';
import 'impl/http_back4app_repository.dart';

class ContatoRepository extends ChangeNotifier {
  List<ContatoModel> contatos = <ContatoModel>[];
  Back4AppRepository _httpRepository = HttpBack4AppRepository();
  carregarContatos(String status) async {
    contatos = await _httpRepository.obterContatoCadastrado("");
  }

  adicionar(ContatoModel contatoModel) async {
    contatos.add(contatoModel);
    await _httpRepository.cadastrarContato(contatoModel);
    notifyListeners();
  }

  alterar(String id, ContatoModel contatoModel) async {
    await _httpRepository.atualizarContato(contatoModel, id);
    var contato = contatos.firstWhere((element) => element.id == id);
    int index = contatos.indexWhere((element) => element.id == id);
    contato = contatoModel;
    contatos.remove(contatos.where((element) => element.id == id).first);
    contatos.insert(index, contato);
    notifyListeners();
  }

  remover(String id) async {
    contatos.remove(contatos.where((element) => element.id == id).first);
    await _httpRepository.deletarContato(id);
    notifyListeners();
  }
}
