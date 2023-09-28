import 'dart:math';

import 'package:hive/hive.dart';
import 'package:trilhaapp/model/tarefa_hive_model.dart';

class TarefaHiveRepository {
  static late Box _box;
  static const String _BOX_NAME = 'tarefas_box';

  TarefaHiveRepository._carregar();

  static Future<TarefaHiveRepository> carregar() async {
    if (Hive.isBoxOpen(_BOX_NAME)) {
      _box = Hive.box(_BOX_NAME);
    } else {
      _box = await Hive.openBox(_BOX_NAME);
    }
    return TarefaHiveRepository._carregar();
  }

  salvar(TarefaHiveModel tarefaHiveModel) {
    _box.add(tarefaHiveModel);
  }

  List<TarefaHiveModel> obterDados(bool naoConcluido) {
    if (naoConcluido) {
      return _box.values.cast<TarefaHiveModel>().where((element) => !element.concluido).toList();
    }
    return _box.values.cast<TarefaHiveModel>().toList();
  }

  alterar(TarefaHiveModel tarefaHiveModel) {
    tarefaHiveModel.save();
  }

  excluir(TarefaHiveModel tarefaHiveModel) {
    tarefaHiveModel.delete();
  }
}
