import 'package:trilhaapp/model/tarefa_model_sqlite.dart';
import 'package:trilhaapp/sqlite/sqlite_dabase.dart';

class TarefaSqliteRepository {

  Future<List<TarefaModelSqlite>> getListDados(bool apenasNaoConcluidos) async {
    List<TarefaModelSqlite> tarefas = [];
    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery('SELECT * FROM tarefas ${apenasNaoConcluidos ? ' WHERE concluido = 0' :''}');
    for (var element in result) {
      tarefas.add(TarefaModelSqlite(int.parse(element['id'].toString()),
          element['descricao'].toString(), element['concluido'] == 1));
    }
    return tarefas;
  }

  Future<void> salvar(TarefaModelSqlite tarefaModelSqlite) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawInsert('INSERT INTO tarefas(descricao, concluido) values(?,?)',
        [tarefaModelSqlite.descricao, tarefaModelSqlite.concluido]);
  }

  Future<void> update(TarefaModelSqlite tarefaModelSqlite) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawUpdate('UPDATE tarefas SET descricao = ?, concluido = ? where id = ?;',
        [tarefaModelSqlite.descricao, tarefaModelSqlite.concluido, tarefaModelSqlite.id]);
  }

  Future<void> delete(int id) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawDelete('DELETE FROM tarefas where id = ?;', [id]);
  }
}
