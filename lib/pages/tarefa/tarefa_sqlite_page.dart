import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa_hive_model.dart';
import 'package:trilhaapp/model/tarefa_model_sqlite.dart';
import 'package:trilhaapp/repository/tarefa_hive_repository.dart';
import 'package:trilhaapp/sqlite/tarefa_sqlite_repository.dart';

class TarefaSqlitePage extends StatefulWidget {
  @override
  _TarefaSqlitePageState createState() => _TarefaSqlitePageState();
}

class _TarefaSqlitePageState extends State<TarefaSqlitePage> {
  TarefaSqliteRepository tarefaRepository = TarefaSqliteRepository();

  var descricaoController = TextEditingController();
  var _tarefas = const <TarefaModelSqlite>[];
  var naoConcluido = false;

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
                        onPressed: () {
                          tarefaRepository.salvar(TarefaModelSqlite(0, descricaoController.text, false));
                          carregaTarefas();
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
                const Text(
                  'Apenas não concluídos',
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                    value: naoConcluido,
                    onChanged: (bool val) async {
                      naoConcluido = val;
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
                      key: Key(_tarefas[index].descricao),
                      child: ListTile(
                        title: Text(_tarefas[index].descricao),
                        trailing: Switch(
                          onChanged: (bool val) {
                            _tarefas[index].concluido = val;
                            tarefaRepository.update(_tarefas[index]);
                            setState(() {});
                          },
                          value: _tarefas[index].concluido,
                        ),
                      ),
                      onDismissed: (DismissDirection dis) {
                        tarefaRepository.delete(_tarefas[index].id);
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
    _tarefas = await tarefaRepository.getListDados(naoConcluido);
    setState(() {});
  }
}
