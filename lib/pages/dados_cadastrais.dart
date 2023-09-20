import 'package:flutter/material.dart';
import 'package:trilhaapp/repository/nivel_repository.dart';

import '../custom_components/text_label_custom.dart';

class DadosCadastraisPage extends StatefulWidget {
  const DadosCadastraisPage({Key? key}) : super(key: key);

  @override
  State<DadosCadastraisPage> createState() => _DadosCadastraisPageState();
}

class _DadosCadastraisPageState extends State<DadosCadastraisPage> {
  var nomeCotroller = TextEditingController(text: "");
  var dataNascimentoCotroller = TextEditingController(text: "");
  DateTime? dataNascimento;
  var niveis = [];
  var nivelRepository = NivelRepository();
  var nivelSelecionado = '';
  var salarioEscolhido = 0.0;
  int tempoExperiencia = 0;
  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meus dados")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              "Tempo de experiência",
            ),
             TextLabelCustom(
              "Pretenção salarial. R\$ ${salarioEscolhido.round().toString()}",
            ),
            Slider(min: 0, max: 40000.0, value: salarioEscolhido,
                onChanged: (double val) {
                  setState(() {
                    salarioEscolhido = val;
                  });
                }),
            TextButton(onPressed: () {}, child: Text('Salvar'))
          ],
        ),
      ),
    );
  }
}
