import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/card_detail_page.dart';
import 'package:trilhaapp/repository/card_detail_repository.dart';

import '../model/card_detail.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  CardDetail? cardDetail;

  @override
  void initState() {
    super.initState();
    carregaDado();
  }

  void carregaDado() async {
    cardDetail = await CardDetailRepository().get();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          child: cardDetail == null ? const LinearProgressIndicator() : InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      CardDetailPage(cardDetail!)));
            },
            child: Hero(
              tag: cardDetail!.id,
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
                            cardDetail!.url,
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              cardDetail!.titulo,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        cardDetail!.texto,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      Container(width: double.infinity, alignment: Alignment.centerRight, child: TextButton(onPressed: () {}, child: Text('Ler Mais'))),
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
