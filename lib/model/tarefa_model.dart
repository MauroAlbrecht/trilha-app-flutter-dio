import 'package:flutter/material.dart';

class TarefaModel{
  String id = UniqueKey().toString();
  String descricao = '';
  bool concluido = false;

  TarefaModel(this.descricao, this.concluido);
}
