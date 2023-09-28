import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trilhaapp/model/cofiguracoes_model.dart';
import 'package:trilhaapp/repository/configuracoes_repository.dart';

class CofiguacoesHivePage extends StatefulWidget {
  @override
  _CofiguacoesHivePageState createState() => _CofiguacoesHivePageState();
}

class _CofiguacoesHivePageState extends State<CofiguacoesHivePage> {
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
  late CofiguracoesRepository repository;
  late ConfiguracoesModel configuracoes;

  @override
  void initState() {
    carregar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(title: Text('Configurações - HIVE')),
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

              configuracoes.nomeUsuario = nomeController.text;
              configuracoes.altura = double.tryParse(alturaController.text) ?? 0;
              configuracoes.temaEscuro = temaEscuro;
              configuracoes.receberNotificacao = receberNotificacoes;

              repository.salvar(configuracoes);

              Navigator.pop(context);

            }, child: const Text('Salvar'))
          ],
        ));
  }

  void carregar() async {
    repository = await CofiguracoesRepository.carregar();
    configuracoes = repository.obterDados();
    nomeController.text = configuracoes.nomeUsuario;
    alturaController.text = configuracoes.nomeUsuario;
    temaEscuro = configuracoes.temaEscuro;
    receberNotificacoes = configuracoes.receberNotificacao;
    setState(() {});
  }
}
