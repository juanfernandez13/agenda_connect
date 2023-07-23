import 'package:agenda_connect/models/contato_model.dart';
import 'package:agenda_connect/repositories/back_4app_repository.dart';
import 'package:agenda_connect/repositories/impl/http_back4app_repository.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

class CadastroPage extends StatefulWidget {
  ContatoModel? contatoModel;
  CadastroPage({super.key, this.contatoModel});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController funcaoController = TextEditingController();
  bool isFavorito = false;
  bool isEmergencia = false;
  Back4AppRepository httpRepository = HttpBack4AppRepository();
  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() {
    if (widget.contatoModel != null) {
      isFavorito = widget.contatoModel!.favorito;
      isEmergencia = widget.contatoModel!.emergencia;
      nomeController.text = widget.contatoModel!.nome;
      telefoneController.text = widget.contatoModel!.telefone;
      emailController.text = widget.contatoModel!.email;
      funcaoController.text = widget.contatoModel!.funcao;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff00DFFD),
        elevation: 0,
        title: Text(
          widget.contatoModel == null
              ? "Adicionar um contato"
              : "Editar um contato",
          style: const TextStyle(color: Colors.black),
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
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
                padding: EdgeInsets.only(top: 40, bottom: 30),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xABFFFFFF),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 60,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Color(0xABFFFFFF),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(500))),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, right: 20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(500))),
                      child: Container(
                        margin: const EdgeInsets.only(left: 15, right: 100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: nomeController,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  label: Text("Nome"),
                                  hintText: "Insira seu nome"),
                            ),
                            TextField(
                              controller: telefoneController,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.phone),
                                  label: Text("Telefone"),
                                  hintText: "Insira seu telefone"),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TelefoneInputFormatter(),
                              ],
                            ),
                            TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  label: Text("E-mail"),
                                  hintText: "Insira seu e-mail"),
                            ),
                            TextField(
                              controller: funcaoController,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.work),
                                  label: Text("Função"),
                                  hintText: "Insira seu Função"),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: isFavorito,
                                    onChanged: (value) {
                                      isFavorito = value ?? false;
                                      setState(() {});
                                    }),
                                Text("Favoritar o contato?")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: isEmergencia,
                                    onChanged: (value) {
                                      isEmergencia = value ?? false;
                                      setState(() {});
                                    }),
                                const Text("Contato de emergência?")
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                ContatoModel contatoModel = ContatoModel(
                                  nome: nomeController.text,
                                  path: "path",
                                  telefone: telefoneController.text,
                                  email: emailController.text,
                                  funcao: funcaoController.text,
                                  favorito: isFavorito,
                                  emergencia: isEmergencia,
                                );
                                if (widget.contatoModel == null) {
                                  contatoModel.gerarCor();
                                  await httpRepository
                                      .cadastrarContato(contatoModel);
                                } else {
                                  contatoModel.colorB = widget.contatoModel!.colorB;
                                  contatoModel.colorG = widget.contatoModel!.colorG;
                                  contatoModel.colorR = widget.contatoModel!.colorR;
                                  await httpRepository.atualizarContato(
                                      contatoModel, widget.contatoModel!.id);
                                }
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 15),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                decoration: BoxDecoration(
                                    color: const Color(0xff00DFFD),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  widget.contatoModel == null
                                      ? "Adicionar contato"
                                      : "Editar contato",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
