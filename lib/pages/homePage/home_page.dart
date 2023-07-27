import 'package:agenda_connect/pages/cadastroPage/cadastro_page.dart';
import 'package:agenda_connect/pages/homePage/details_contact.dart';
import 'package:agenda_connect/repositories/contatos_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> opcoes = ["Todos os contatos", "Emergência", "Favoritos"];
  String dropDownValue = "Todos os contatos";

  @override
  Widget build(BuildContext context) {
    Provider.of<ContatoRepository>(context).carregarContatos(dropDownValue);
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
        child: Stack(
          children: [
            const FundoHomePage(),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Contatos",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                  ),
                ),
                Consumer<ContatoRepository>(
                    builder: (_, contatoRepository, widget) {
                  return DropdownButton(
                    value: dropDownValue,
                    items: opcoes.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(
                          () => dropDownValue = value ?? "Todos os contatos");
                      contatoRepository.carregarContatos(dropDownValue);
                    },
                  );
                }),
                Expanded(child: Consumer<ContatoRepository>(
                    builder: (context, contatoRepository, widget) {
                  return ListView.builder(
                    itemCount: contatoRepository.contatos.length,
                    itemBuilder: (context, index) {
                      var contato = contatoRepository.contatos[index];
                      return DetailsContact(
                        contatoModel: contato,
                        status: dropDownValue,
                      );
                    },
                  );
                })),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CadastroPage()));
                    },
                    child: const CircleAvatar(
                      backgroundColor: Color(0xff00DFFD),
                      radius: 30,
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class FundoHomePage extends StatelessWidget {
  const FundoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 200),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(500),
                    topRight: Radius.circular(500),
                  )),
              width: 100,
              height: 200,
              child: Container(
                margin: const EdgeInsets.only(bottom: 50, right: 50, top: 50),
                decoration: const BoxDecoration(
                    color: Color(0xff00DFFD),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(500),
                        topRight: Radius.circular(500))),
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(500),
                  )),
              width: 200,
              height: 200,
              child: Container(
                margin: const EdgeInsets.only(bottom: 60, left: 60),
                decoration: const BoxDecoration(
                    color: Color(0xff00DFFD),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(500),
                    )),
              ),
            ),
          ],
        )
      ],
    );
  }
}
