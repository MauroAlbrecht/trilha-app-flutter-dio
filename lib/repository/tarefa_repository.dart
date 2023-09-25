import 'package:trilhaapp/model/tarefa.dart';

class TarefaRepository {
  final List<Tarefa>  _tarefas = [];

  Future<List<Tarefa>> listarTarefas() async {
    await Future.delayed(Duration(seconds: 2));
    return _tarefas;
  }

  void alterar(String id, bool concluido) async {
    await Future.delayed(Duration(seconds: 2));
    _tarefas.where((element) => element.id == id)
    .first
    .concluido = concluido;
  }

  void addTarefa(Tarefa tarefa) async {
    await Future.delayed(Duration(seconds: 2));
    _tarefas.add(tarefa);
  }
}
