import 'package:flutter/material.dart';

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
            SizedBox(
              height: 10,
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
            TextButton(onPressed: () {}, child: Text('Salvar'))
          ],
        ),
      ),
    );
  }
}
