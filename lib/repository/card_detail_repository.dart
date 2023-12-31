import 'package:trilhaapp/model/card_detail_model.dart';

class CardDetailRepository {
  Future<CardDetailModel> get() async {
    await Future.delayed(const Duration(seconds: 5));
    return CardDetailModel(titulo: "Meu Card",
        texto: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        url: "https://hermes.digitalinnovation.one/assets/diome/logo.png",
        id: 1);
  }
}
