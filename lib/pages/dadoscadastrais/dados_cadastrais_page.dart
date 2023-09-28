import 'package:flutter/material.dart';
import 'package:trilhaapp/repository/linguagens_repository.dart';
import 'package:trilhaapp/repository/nivel_repository.dart';

import '../../custom_components/text_label_custom.dart';

class DadosCadastraisPage extends StatefulWidget {
  const DadosCadastraisPage({Key? key}) : super(key: key);

  @override
  State<DadosCadastraisPage> createState() => _DadosCadastraisPageState();
}

class _DadosCadastraisPageState extends State<DadosCadastraisPage> {
  var nomeCotroller = TextEditingController(text: "");
  var dataNascimentoCotroller = TextEditingController(text: "");
  DateTime? dataNascimento;
  var linguagens = [];
  var niveis = [];
  var nivelRepository = NivelRepository();
  var linguagensRepository = LinguagensRepository();
  var nivelSelecionado = '';
  var salarioEscolhido = 0.0;
  int tempoExperiencia = 0;
  var linguagensSelecionadas = [];
  var salvando = false;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meus dados")),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: salvando
            ?   Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  TextLabelCustom(
                    "Nome",
                  ),
                  TextField(
                    controller: nomeCotroller,
                  ),
                  TextLabelCustom("Data de nascimento"),
                  TextField(
                    readOnly: true,
                    controller: dataNascimentoCotroller,
                    onTap: () async {
                      var data = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900, 1, 1), lastDate: DateTime(2023, 10, 23));
                      if (data != null) {
                        dataNascimentoCotroller.text = data.toString();
                      }
                      data = dataNascimento;
                    },
                  ),
                  const TextLabelCustom(
                    "Nível de experiência",
                  ),
                  Column(
                      children: niveis
                          .map((nivel) => RadioListTile(
                              dense: true,
                              selected: nivelSelecionado == nivel,
                              title: Text(nivel.toString()),
                              value: nivel.toString(),
                              groupValue: nivelSelecionado,
                              onChanged: (val) {
                                setState(() {
                                  nivelSelecionado = val.toString();
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
                              value: linguagensSelecionadas.contains(linguagem),
                              onChanged: (bool? val) {
                                setState(() {
                                  if (val!) {
                                    linguagensSelecionadas.add(linguagem);
                                  } else {
                                    linguagensSelecionadas.remove(linguagem);
                                  }
                                });
                              }))
                          .toList()),
                  TextLabelCustom(
                    "Tempo de experiencia",
                  ),
                  DropdownButton(
                      value: tempoExperiencia,
                      items: retornaItensMenuExperiencia(20),
                      onChanged: (value) {
                        setState(() {
                          tempoExperiencia = value!;
                        });
                      }),
                  TextLabelCustom(
                    "Pretenção salarial. R\$ ${salarioEscolhido.round().toString()}",
                  ),
                  Slider(
                      min: 0,
                      max: 40000.0,
                      value: salarioEscolhido,
                      onChanged: (double val) {
                        setState(() {
                          salarioEscolhido = val;
                        });
                      }),
                  TextButton(
                    child: Text('Salvar'),
                    onPressed: () {
                      setState(() {
                        salvando = true;
                      });

                      Future.delayed(
                        Duration(seconds: 2),
                        () => {
                          setState(() {
                            salvando = false;
                          }),

                          Navigator.pop(context)
                        },
                      );
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
}
