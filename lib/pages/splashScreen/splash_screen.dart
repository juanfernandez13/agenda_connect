import 'package:agenda_connect/pages/homePage/home_page.dart';
import 'package:flutter/material.dart';

import '../../repositories/contatos_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ContatoRepository contatoRepository = ContatoRepository();
  @override
  void initState() {
    super.initState();
    carregarPage();
  }

  void carregarPage() async{
    await contatoRepository.carregarContatos("");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xff00DFFD), Color(0xff98F2FE), Color(0xffDCEFF1)],
          stops: [0.4, 0.7, 0.9],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 250,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "lib/assets/images/contatos.png",
                      ),
                      fit: BoxFit.contain)),
            ),
            const SizedBox(height: 15),
            Text(
              "AgendaConnect",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 170,
            ),
            const CircularProgressIndicator(
              color: Colors.black,
            )
          ],
        ),
      ),
    ));
  }
}
