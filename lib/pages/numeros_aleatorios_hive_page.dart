import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NumerosAleatoriosHivePage extends StatefulWidget {
  @override
  _NumerosAleatoriosHivePageState createState() => _NumerosAleatoriosHivePageState();
}

class _NumerosAleatoriosHivePageState extends State<NumerosAleatoriosHivePage> {
  int? numeroGerado = 0;
  final CHAVE_NUMERO_ALEATORIO = 'numero_aleatorio';
  final BOX_NAME = 'box_numeros_aleatorios';
  late Box boxNumerosAleatorios;

  @override
  void initState() {
    carregaDados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Números aleatórios - HIVE')),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              numeroGerado =  Random().nextInt(1000);
              boxNumerosAleatorios.put(CHAVE_NUMERO_ALEATORIO, numeroGerado);
              setState(() {});
            }),
        body: Center(child: Text(numeroGerado.toString())));
  }

  void carregaDados() async {
    if (Hive.isBoxOpen(BOX_NAME)) {
      boxNumerosAleatorios = Hive.box(BOX_NAME);
    } else {
      boxNumerosAleatorios = await Hive.openBox(BOX_NAME);
    }
    numeroGerado = boxNumerosAleatorios.get(CHAVE_NUMERO_ALEATORIO) ?? 0;
    setState(() {});
  }
}
