import 'package:trilhaapp/model/tarefa.dart';

class TarefaRepository {
  final List<Tarefa>  _tarefas = [];

  Future<List<Tarefa>> getTarefas(bool apenasNaoConcluidos) async {
    await Future.delayed(const Duration(seconds: 1));
    if(apenasNaoConcluidos){
      return _tarefas.where((element) => element.concluido == false).toList();
    }
    return _tarefas;
  }

  Future<void> alterar(String id, bool concluido) async {
    await Future.delayed(const Duration(seconds: 1));
    _tarefas.where((element) => element.id == id)
    .first
    .concluido = concluido;
  }

  Future<void> remover(String id) async {
    _tarefas.remove(_tarefas.where((element) => element.id == id).first);
  }

  Future<void> addTarefa(Tarefa tarefa) async {
    await Future.delayed(const Duration(seconds: 1));
    _tarefas.add(tarefa);
  }
}
