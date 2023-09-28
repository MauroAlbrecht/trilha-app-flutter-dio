import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa_model.dart';
import 'package:trilhaapp/repository/tarefa_repository.dart';

class TarefaPage extends StatefulWidget {
  @override
  _TarefaPageState createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  var tarefaRepository = TarefaRepository();
  var descricaoController = TextEditingController();
  var _tarefas = const <TarefaModel>[];
  var apenasConcuidos = false;
  @override
  void initState() {
    carregaTarefas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          descricaoController.text = '';

          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text('Adiconar Tarefa'),
                  content: TextField(
                    controller: descricaoController,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar')),
                    TextButton(
                        onPressed: () async {
                          await tarefaRepository.addTarefa(TarefaModel(descricaoController.text, false));

                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: const Text('Salvar')),
                  ],
                );
              });
        },
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Apenas não concluídos', style: TextStyle(fontSize: 18),),
                Switch(value: apenasConcuidos, onChanged: (bool val) async {
                  apenasConcuidos  = val;
                  await carregaTarefas();
                  setState(() {});
                })
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _tarefas.length,
                  itemBuilder: (BuildContext bc, int index) {
                    return Dismissible(
                      key: Key(_tarefas[index].id),
                      child: ListTile(
                        title: Text(_tarefas[index].descricao),
                        trailing: Switch(
                          onChanged: (bool val) async {
                            await tarefaRepository.alterar(_tarefas[index].id, val);
                            setState(() {});
                          },
                          value: _tarefas[index].concluido,
                        ),
                      ),
                      onDismissed: (DismissDirection dis) async {
                        await tarefaRepository.remover(_tarefas[index].id);
                        carregaTarefas();
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> carregaTarefas() async {
      _tarefas = await tarefaRepository.getTarefas(apenasConcuidos);
  }
}
