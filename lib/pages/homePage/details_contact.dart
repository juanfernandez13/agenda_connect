import 'package:flutter/material.dart';

class DetailsContact extends StatelessWidget {
  final Color color;
  final String nome;
  final String funcao;
  final String telefone;
  final String path;
  final String email;
  final bool favorito;

  DetailsContact(
      {super.key,
      required this.color,
      required this.nome,
      required this.funcao,
      required this.email,
      required this.path,
      required this.telefone,
      required this.favorito});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: color,
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: Icon(Icons.person, color: Colors.black,size: 40,),
            ),
            title: Text(nome, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
            subtitle: Text(funcao),
            
          ),

          ListTile(
            leading: const Icon(Icons.phone, color: Colors.black,),
            title: Text(telefone),
          ),
          
          ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            leading: const Icon(Icons.email, color: Colors.black,),
            title: Text(email),
            trailing: favorito ? const Icon(Icons.star, color: Colors.black,) : const Icon(Icons.star_border, color: Colors.black,),
          )
        ],
      ),
    );
  }
}
