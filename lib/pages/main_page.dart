import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/card_page.dart';
import 'package:trilhaapp/pages/list_view_horizontal.dart';
import 'package:trilhaapp/pages/tarefa_page.dart';

import '../custom_components/drawer_custom.dart';
import 'dadoscadastrais/dados_cadastrais_page.dart';
import 'image_assets_page.dart';
import 'list_view_vertical.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Main Page"),
        ),
        drawer: DrawerCustom(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    posicaoPagina = value;
                  });
                },
                children:  [
                  CardPage(),
                  ImageAssetsPage(),
                  ListViewVertical(),
                  ListViewHorizontal(),
                  TarefaPage(),
                ],
              ),
            ),
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  controller.jumpToPage(value);
                },
                currentIndex: posicaoPagina,
                items: const [
                  BottomNavigationBarItem(label: "Pag1", icon: Icon(Icons.home)),
                  BottomNavigationBarItem(label: "Pag2", icon: Icon(Icons.add)),
                  BottomNavigationBarItem(label: "ListView V", icon: Icon(Icons.person_outline_outlined)),
                  BottomNavigationBarItem(label: "ListView H", icon: Icon(Icons.image)),
                  BottomNavigationBarItem(label: "Tarefa", icon: Icon(Icons.list)),
                ])
          ],
        ),
      ),
    );
  }
}
