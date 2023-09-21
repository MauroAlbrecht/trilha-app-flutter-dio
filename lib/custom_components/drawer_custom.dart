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
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  builder: (BuildContext bc) {
                    return Wrap(//wrap agrupa os elmentos e tira o espaço não utilizado antes estava Column
                      children: [
                        ListTile(
                          title: Text('Camêra'),
                          leading: Icon(Icons.camera_alt),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text('Galeria'),
                          leading: Icon(Icons.photo_album),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  });
            },
            child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blueAccent),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.network(
                    "https://hermes.digitalinnovation.one/assets/diome/logo.png",
                  ),
                ),
                accountName: Text('Mauro Albrecht'),
                accountEmail: Text('mauroin@gmail.com')),
          ),
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
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(Icons.privacy_tip_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Termos de uso e privacidade"),
                    ],
                  )),
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  builder: (BuildContext bc) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      child: Column(
                        children: [
                          Text('Termos de Privacidade',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          SizedBox(height: 10,),
                          Text('Nesse pull request, a normalização da data corrigiu o bug na estabilidade do protocolo de transferência de dados. Nesse pull request, a normalização da data corrigiu o bug na estabilidade do protocolo de transferência de dados. Nesse pull request, a normalização da data corrigiu o bug na estabilidade do protocolo de transferência de dados. Nesse pull request, a normalização da data corrigiu o bug na estabilidade do protocolo de transferência de dados. Nesse pull request, a normalização da data corrigiu o bug na estabilidade do protocolo de transferência de dados.')
                        ],
                      ),
                    );
                  });
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(Icons.album),
                      SizedBox(
                        width: 5,
                      ),
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
