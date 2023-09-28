import 'package:flutter/material.dart';
import 'package:trilhaapp/model/dados_cadastrais_model.dart';
import 'package:trilhaapp/repository/dados_cadastrais_repository.dart';
import 'package:trilhaapp/repository/linguagens_repository.dart';
import 'package:trilhaapp/repository/nivel_repository.dart';

import '../../custom_components/text_label_custom.dart';

class DadosCadastraisHivePage extends StatefulWidget {
  const DadosCadastraisHivePage({Key? key}) : super(key: key);

  @override
  State<DadosCadastraisHivePage> createState() => _DadosCadastraisHivePageState();
}

class _DadosCadastraisHivePageState extends State<DadosCadastraisHivePage> {
  late DadosCadastraisRepository dadosCadastraisRepository;

  var nomeCotroller = TextEditingController(text: "");
  var dataNascimentoCotroller = TextEditingController(text: "");
  var linguagens = [];
  var niveis = [];
  var nivelRepository = NivelRepository();
  var linguagensRepository = LinguagensRepository();
  var salvando = false;
  var dadosCadastraisModel = DadosCadastraisModel.vazio();

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    carregarDados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meus dados - HIVE")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: salvando
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const TextLabelCustom(
                    "Nome",
                  ),
                  TextField(
                    controller: nomeCotroller,
                  ),
                  const TextLabelCustom("Data de nascimento"),
                  TextField(
                    readOnly: true,
                    controller: dataNascimentoCotroller,
                    onTap: () async {
                      var data = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900, 1, 1), lastDate: DateTime(2023, 10, 23));
                      if (data != null) {
                        dataNascimentoCotroller.text = data.toString();
                      }
                      dadosCadastraisModel.dataNascimento = data;
                    },
                  ),
                  const TextLabelCustom(
                    "Nível de experiência",
                  ),
                  Column(
                      children: niveis
                          .map((nivel) => RadioListTile(
                              dense: true,
                              selected: dadosCadastraisModel.nivelExperiencia == nivel,
                              title: Text(nivel.toString()),
                              value: nivel.toString(),
                              groupValue: dadosCadastraisModel.nivelExperiencia,
                              onChanged: (val) {
                                setState(() {
                                  dadosCadastraisModel.nivelExperiencia = val.toString();
                                });
                              }))
                          .toList()),
                  const TextLabelCustom(
                    "Linguagens Preferidas",
                  ),
                  Column(
                      children: linguagens
                          .map((linguagem) => CheckboxListTile(
                              dense: true,
                              title: Text(linguagem.toString()),
                              value: dadosCadastraisModel.linguagens.contains(linguagem),
                              onChanged: (bool? val) {
                                setState(() {
                                  if (val!) {
                                    dadosCadastraisModel.linguagens.add(linguagem);
                                  } else {
                                    dadosCadastraisModel.linguagens.remove(linguagem);
                                  }
                                });
                              }))
                          .toList()),
                  const TextLabelCustom(
                    "Tempo de experiencia",
                  ),
                  DropdownButton(
                      value: dadosCadastraisModel.tempoExperiencia,
                      items: retornaItensMenuExperiencia(20),
                      onChanged: (value) {
                        setState(() {
                          dadosCadastraisModel.tempoExperiencia = value!;
                        });
                      }),
                  TextLabelCustom(
                    "Pretenção salarial. R\$ ${dadosCadastraisModel.salario == null ? 0 :dadosCadastraisModel.salario!.round().toString()}",
                  ),
                  Slider(
                      min: 0,
                      max: 40000.0,
                      value: dadosCadastraisModel.salario ?? 0,
                      onChanged: (double val) {
                        setState(() {
                          dadosCadastraisModel.salario = val;
                        });
                      }),
                  TextButton(
                    child: const Text('Salvar'),
                    onPressed: () {

                      setState(() {
                        salvando = true;
                      });

                      Future.delayed(const Duration(seconds: 2));

                      dadosCadastraisModel.nome = nomeCotroller.text;

                      dadosCadastraisRepository.salvar(dadosCadastraisModel);

                      setState(() {
                        salvando = false;
                      });

                      Navigator.pop(context);
                    },
                  )
                ],
              ),
      ),
    );
  }

  List<DropdownMenuItem> retornaItensMenuExperiencia(int qtdMaxima) {
    var itens = <DropdownMenuItem>[];
    for (var i = 0; i <= qtdMaxima; i++) {
      itens.add(DropdownMenuItem(
        value: i,
        child: Text(i == qtdMaxima ? 'Mais de $i anos' : i.toString()),
      ));
    }
    return itens;
  }

  void carregarDados() async {
    dadosCadastraisRepository = await DadosCadastraisRepository.carregar();
    dadosCadastraisModel = dadosCadastraisRepository.obterDados();
    nomeCotroller.text = dadosCadastraisModel.nome!;
    dataNascimentoCotroller.text = dadosCadastraisModel.dataNascimento!.toIso8601String();
    setState(() {});
  }
}
