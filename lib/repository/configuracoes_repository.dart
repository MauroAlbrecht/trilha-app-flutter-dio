import 'package:hive/hive.dart';
import 'package:trilhaapp/model/cofiguracoes_model.dart';

class CofiguracoesRepository {
  static late Box _box;
  static const String _BOX_NAME = 'configuracoes_box';
  static const String _BOX_KEY = 'configuracoes';

  CofiguracoesRepository._carregar();

  static Future<CofiguracoesRepository> carregar() async {
    if (Hive.isBoxOpen(_BOX_NAME)) {
      _box = Hive.box(_BOX_NAME);
    } else {
      _box = await Hive.openBox(_BOX_NAME);
    }
    return CofiguracoesRepository._carregar();
  }

  void salvar(ConfiguracoesModel configuracoes) {
    _box.put(_BOX_KEY, {
      'nomeUsuario': configuracoes.nomeUsuario,
      'altura': configuracoes.altura,
      'receberNotificacao': configuracoes.receberNotificacao,
      'temaEscuro': configuracoes.temaEscuro,
    });
  }

  ConfiguracoesModel obterDados() {

    var configuracoes = _box.get(_BOX_KEY);

    if(configuracoes == null) {
      return ConfiguracoesModel('', 0, false, false);
    }

    return ConfiguracoesModel(
        configuracoes['nomeUsuario'],
        configuracoes['altura'],
        configuracoes['receberNotificacao'],
        configuracoes['temaEscuro']);
  }
}
