import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CofiguacoesSharedPage extends StatefulWidget {
  @override
  _CofiguacoesSharedPageState createState() => _CofiguacoesSharedPageState();
}

class _CofiguacoesSharedPageState extends State<CofiguacoesSharedPage> {
  final CHAVE_NOME_USUARIO = 'nome_usuario';
  final CHAVE_MODO_ESCURO = 'modo_escuro';
  final CHAVE_RECEBER_NOTIFICACAO = 'receber_notificacao';
  final CHAVE_ALTURA = 'altura';
  String? nome;
  double? altura;
  bool receberNotificacoes = false;
  bool temaEscuro = false;
  late SharedPreferences storage;
  var nomeController = TextEditingController();
  var alturaController = TextEditingController();

  @override
  void initState() {
    carregar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(title: Text('Configurações')),
        body: ListView(
          children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Nome usuário'),
              controller: nomeController,
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Altura'),
              controller: alturaController,
              keyboardType: TextInputType.number,
            ),
            SwitchListTile(
                value: receberNotificacoes,
                title: const Text('Receber notificações'),
                onChanged: (bool value) {
                  setState(() {
                    receberNotificacoes = value;
                  });
                }),
            SwitchListTile(
                value: temaEscuro,
                title: const Text('Tema escuro'),
                onChanged: (bool value) {
                  setState(() {
                    temaEscuro = value;
                  });
                }),
            TextButton(onPressed: () async {

              await storage.setString(CHAVE_NOME_USUARIO, nomeController.text);
              await storage.setDouble(CHAVE_ALTURA, double.tryParse(alturaController.text) ?? 0);
              await storage.setBool(CHAVE_MODO_ESCURO, temaEscuro);
              await storage.setBool(CHAVE_RECEBER_NOTIFICACAO, receberNotificacoes);
              Navigator.pop(context);

            }, child: const Text('Salvar'))
          ],
        ));
  }

  void carregar() async {
    storage = await SharedPreferences.getInstance();
    nomeController.text = storage.getString(CHAVE_NOME_USUARIO) ?? '';
    alturaController.text = (storage.getDouble(CHAVE_ALTURA) ?? '').toString();
    temaEscuro = storage.getBool(CHAVE_MODO_ESCURO) ?? false;
    receberNotificacoes = storage.getBool(CHAVE_RECEBER_NOTIFICACAO) ?? false;
    setState(() {});
  }
}
