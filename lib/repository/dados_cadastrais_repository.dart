import 'package:hive/hive.dart';
import 'package:trilhaapp/model/dados_cadastrais_model.dart';

class DadosCadastraisRepository {
  static late Box _box;
  static const String _BOX_NAME = 'dados_cadastrais_box';
  static const String _BOX_KEY = 'dados_cadastrais';

  DadosCadastraisRepository._carregar();

  static Future<DadosCadastraisRepository> carregar() async {
    if (Hive.isBoxOpen(_BOX_NAME)) {
      _box = Hive.box(_BOX_NAME);
    } else {
      _box = await Hive.openBox(_BOX_NAME);
    }
    return DadosCadastraisRepository._carregar();
  }

  void salvar(DadosCadastraisModel dadosCadastraisModel) {
    _box.put(_BOX_KEY, dadosCadastraisModel);
  }

  DadosCadastraisModel obterDados() {
    var dadosCadastrais = _box.get(_BOX_KEY);
    if (dadosCadastrais == null) {
      return DadosCadastraisModel();
    }
    return dadosCadastrais;
  }
}
