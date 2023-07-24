import 'package:agenda_connect/models/contato_model.dart';

abstract class Back4AppRepository {
  
  Future<List<ContatoModel>> obterContatoCadastrado(String status);
  Future<void> cadastrarContato(ContatoModel contatoModel);
  Future<void> atualizarContato(ContatoModel contatoModel, String id);
  Future<void> deletarContato(String id);
}
