import 'dart:io';
import 'package:agenda_connect/models/contato_model.dart';
import 'package:agenda_connect/repositories/back_4app_repository.dart';
import 'package:agenda_connect/repositories/contatos_repository.dart';
import 'package:agenda_connect/repositories/impl/http_back4app_repository.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:provider/provider.dart';

//ignore: must_be_immutable
class CadastroPage extends StatefulWidget {
  ContatoModel? contatoModel;
  CadastroPage({super.key, this.contatoModel});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  TextEditingController nomeController = TextEditingController(text: "");
  TextEditingController telefoneController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController funcaoController = TextEditingController(text: "");
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
      widget.contatoModel!.path == ''
          ? photo == null
          : photo = XFile(widget.contatoModel!.path);
    }
    setState(() {});
  }

  XFile? photo;

  cropImage(XFile imageFile) async {
    if (imageFile.path != "") {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );

      if (croppedFile != null) {
        await GallerySaver.saveImage(croppedFile.path);
        photo = XFile(croppedFile.path);
        setState(() {});
      }
    }
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
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 30),
                child: InkWell(
                  onTap: () async {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return Wrap(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text("Câmera"),
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  photo = await picker.pickImage(
                                      source: ImageSource.camera);

                                  if (photo != null) {
                                    String path = (await path_provider
                                            .getApplicationDocumentsDirectory())
                                        .path;
                                    String name = basename(photo!.path);
                                    photo!.saveTo("$path/$name");
                                    await GallerySaver.saveImage(photo!.path);
                                    cropImage(photo!);
                                    setState(() {});
                                  }
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.browse_gallery),
                                title: const Text("Galeria"),
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  photo = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  Navigator.pop(context);
                                  if (photo != null) {
                                    cropImage(photo!);
                                  }
                                  setState(() {});
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: const Color(0xABFFFFFF),
                    child: photo != null
                        ? Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(File(photo!.path)),
                                    fit: BoxFit.cover)),
                          )
                        : const CircleAvatar(
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
                            InputTextField(controller: nomeController, icon: Icons.person, hint: "Insira seu nome", label: "Nome",),
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
                            InputTextField(controller: emailController, icon: Icons.email, hint: "Insira seu email", label: "Email",),
                            InputTextField(controller: funcaoController, icon: Icons.work, hint: "Insira sua função", label: "Função",),
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
                              onTap: () {
                                ContatoModel contatoModel = ContatoModel();
                                contatoModel.nome = nomeController.text;
                                contatoModel.telefone = telefoneController.text;
                                contatoModel.email = emailController.text;
                                contatoModel.path =
                                    photo == null ? "" : photo!.path;
                                contatoModel.funcao = funcaoController.text;
                                contatoModel.favorito = isFavorito;
                                contatoModel.emergencia = isEmergencia;
                                if (widget.contatoModel == null) {
                                  contatoModel.gerarCor();
                                  Provider.of<ContatoRepository>(context,
                                          listen: false)
                                      .adicionar(contatoModel);
                                } else {
                                  contatoModel.colorB =
                                      widget.contatoModel!.colorB;
                                  contatoModel.colorG =
                                      widget.contatoModel!.colorG;
                                  contatoModel.colorR =
                                      widget.contatoModel!.colorR;
                                  Provider.of<ContatoRepository>(context,
                                          listen: false)
                                      .alterar(widget.contatoModel!.id,
                                          contatoModel);
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

class InputTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String label;
  final String hint;
  const InputTextField(
      {super.key,
      required this.controller,
      required this.icon,
      required this.hint,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: Icon(icon), label: Text(label), hintText: hint),
    );
  }
}
