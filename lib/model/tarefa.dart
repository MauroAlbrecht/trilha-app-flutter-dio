import 'package:flutter/material.dart';

class Tarefa{
  String id = UniqueKey().toString();
  String descricao = '';
  bool concluido = false;

  Tarefa(this.descricao, this.concluido);
}
