import 'dart:math';

class GeradorNumeroAleatorio {

  static int geradorNumeroAleatorio() {
    Random numeroAleatorio = Random();
    return numeroAleatorio.nextInt(1000);
  }
}
