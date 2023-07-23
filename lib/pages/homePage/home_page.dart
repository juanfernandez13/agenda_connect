import 'package:agenda_connect/models/contato_model.dart';
import 'package:agenda_connect/pages/cadastroPage/cadastro_page.dart';
import 'package:agenda_connect/pages/homePage/details_contact.dart';
import 'package:agenda_connect/repositories/back_4app_repository.dart';
import 'package:agenda_connect/repositories/impl/http_back4app_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> opcoes = ["Todos os contatos", "Emergência", "Favoritos"];
  String dropDownValue = "Todos os contatos";
  Back4AppRepository httpRepository = HttpBack4AppRepository();
  List<ContatoModel> contatosList = [];
  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    contatosList = await httpRepository.obterContatoCadastrado(dropDownValue);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xff00DFFD), Color(0xff98F2FE), Color(0xffDCEFF1)],
          stops: [0.4, 0.7, 0.9],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Contatos",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
              ),
            ),
            DropdownButton(
              value: dropDownValue,
              items: opcoes.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropDownValue = value ?? "Todos os contatos";
                });
              },
            ),
            Expanded(
                child: ListView(
                    children: contatosList.map((contato) {
              return DetailsContact(contatoModel: contato);
            }).toList())),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CadastroPage()));
                },
                child: const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.add),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}