import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumerosAleatoriosSharedPreferencesPage extends StatefulWidget {
  @override
  _NumerosAleatoriosSharedPreferencesPageState createState() => _NumerosAleatoriosSharedPreferencesPageState();
}

class _NumerosAleatoriosSharedPreferencesPageState extends State<NumerosAleatoriosSharedPreferencesPage> {
  int? numeroGerado = 0;
  final CHAVE_NUMERO_ALEATORIO = 'numero_aleatorio';

  @override
  void initState() {
    carregaNumero();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Gerador de números aleatórios')),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              final storage = await SharedPreferences.getInstance();
              numeroGerado = Random().nextInt(1000);
              storage.setInt(CHAVE_NUMERO_ALEATORIO, numeroGerado!);
              setState(() {});
            }),
        body: Center(child: Text(numeroGerado.toString())));
  }

  void carregaNumero() async {
    final storage = await SharedPreferences.getInstance();
    numeroGerado = storage.getInt(CHAVE_NUMERO_ALEATORIO);
    setState(() {});
  }
}
