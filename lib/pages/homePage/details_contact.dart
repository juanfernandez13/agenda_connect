import 'dart:io';

import 'package:agenda_connect/models/contato_model.dart';
import 'package:agenda_connect/pages/cadastroPage/cadastro_page.dart';
import 'package:agenda_connect/repositories/back_4app_repository.dart';
import 'package:agenda_connect/repositories/impl/http_back4app_repository.dart';
import 'package:flutter/material.dart';

class DetailsContact extends StatelessWidget {
  final ContatoModel contatoModel;

  DetailsContact({super.key, required this.contatoModel});

  @override
  Widget build(BuildContext context) {
    Back4AppRepository httpRepository = HttpBack4AppRepository();
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: contatoModel.gerarCor(),
      child: Column(
        children: [
          ListTile(
            leading: contatoModel.path != "" ?Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(File(contatoModel.path)),
                                    fit: BoxFit.cover)),
                          ): CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: Icon(
                Icons.person,
                color: Colors.black,
                size: 40,
              ),
            ),
            title: Text(
              contatoModel.nome,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(contatoModel.funcao),
            trailing: SizedBox(
              width: 96,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CadastroPage(
                                    contatoModel: contatoModel,
                                  )));
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      httpRepository.deletarContato(contatoModel.id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.phone,
              color: Colors.black,
            ),
            title: Text(contatoModel.telefone),
          ),
          ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              leading: const Icon(
                Icons.email,
                color: Colors.black,
              ),
              title: Text(contatoModel.email),
              trailing: Padding(
                padding: const EdgeInsets.all(8),
                child: contatoModel.favorito
                    ? IconButton(
                        onPressed: () {
                          ContatoModel updateContato = contatoModel;
                          contatoModel.favorito = false;
                          httpRepository.atualizarContato(
                              updateContato, contatoModel.id);
                        },
                        icon: const Icon(Icons.star, color: Colors.black))
                    : IconButton(
                        onPressed: () {
                          ContatoModel updateContato = contatoModel;
                          contatoModel.favorito = true;
                          httpRepository.atualizarContato(
                              updateContato, contatoModel.id);
                        },
                        icon:
                            const Icon(Icons.star_border, color: Colors.black)),
              ))
        ],
      ),
    );
  }
}
