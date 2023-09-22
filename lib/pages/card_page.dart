import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/card_detail_page.dart';

import '../model/card_detail.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  var cardDetail = CardDetail(titulo: "Meu Card",
      texto: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
    url: "https://hermes.digitalinnovation.one/assets/diome/logo.png",
  id: 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CardDetailPage(cardDetail)));
            },
            child: Hero(
              tag: cardDetail.id,
              child: Card(
                elevation: 3,
                shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            cardDetail.url,
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(cardDetail.titulo, style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700
                            ),),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(cardDetail.texto,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.justify,),
                      Container(
                          width: double.infinity,
                          alignment: Alignment.centerRight,
                          child: TextButton(onPressed: () {}, child: Text('Ler Mais'))),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
