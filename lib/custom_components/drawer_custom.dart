import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/dados_cadastrais.dart';

class DrawerCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network(
                  "https://hermes.digitalinnovation.one/assets/diome/logo.png",
                ),
              ),
              accountName: Text('Mauro Albrecht'),
              accountEmail: Text('mauroin@gmail.com')),
          InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Dados cadastráis"),
                    ],
                  )),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => DadosCadastraisPage()));
            },
          ),
          Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(padding: const EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity, child: Row(
                    children: [
                      Icon(Icons.privacy_tip_outlined),
                      SizedBox(width: 5,),
                      Text("Termos de uso e privacidade"),
                    ],
                  )),
            ),
            onTap: () {},
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(padding: const EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity, child: Row(
                    children: [
                      Icon(Icons.album),
                      SizedBox(width: 5,),
                      Text("Configurações"),
                    ],
                  )),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
