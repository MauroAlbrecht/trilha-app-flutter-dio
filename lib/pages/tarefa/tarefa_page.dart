import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa_hive_model.dart';
import 'package:trilhaapp/model/tarefa_model.dart';
import 'package:trilhaapp/repository/tarefa_hive_repository.dart';
import 'package:trilhaapp/repository/tarefa_repository.dart';

class TarefaPage extends StatefulWidget {
  @override
  _TarefaPageState createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  late TarefaHiveRepository tarefaRepository;

  var descricaoController = TextEditingController();
  var _tarefas = const <TarefaHiveModel>[];
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
                          tarefaRepository.salvar(TarefaHiveModel.criar(descricaoController.text, false));
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
                            tarefaRepository.alterar(_tarefas[index]);
                            setState(() {});
                          },
                          value: _tarefas[index].concluido,
                        ),
                      ),
                      onDismissed: (DismissDirection dis) {
                        tarefaRepository.excluir(_tarefas[index]);
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
    tarefaRepository = await TarefaHiveRepository.carregar();
    _tarefas = tarefaRepository.obterDados(this.naoConcluido);
    setState(() {});
  }
}
