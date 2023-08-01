import 'package:agenda_connect/pages/splashScreen/splash_screen.dart';
import 'package:agenda_connect/repositories/contatos_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ContatoRepository>(create: (_) => ContatoRepository()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
