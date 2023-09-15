import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trilhaapp/gerador_numero_aleatorio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var numeroAleatorio = 0;
  var numeroCliques = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Número de cliques: $numeroCliques'),
            Text('Número aleatório: $numeroAleatorio'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              numeroCliques++;
              numeroAleatorio = GeradorNumeroAleatorio.geradorNumeroAleatorio();
            });
          }),
    );
  }
}
