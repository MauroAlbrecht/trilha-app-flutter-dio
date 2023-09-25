import 'package:flutter/material.dart';

import '../custom_components/app_images.dart';

class ListViewVertical extends StatefulWidget {
  const ListViewVertical({Key? key}) : super(key: key);

  @override
  State<ListViewVertical> createState() => _ListViewVerticalState();
}

class _ListViewVerticalState extends State<ListViewVertical> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Image.asset(AppImages.user1),
          title: Text('Usuário 1'),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Olá, tudo bem?'),
              Text('08:59'),
            ],
          ),
          trailing: PopupMenuButton<String> (
            onSelected: (menu) {},
            itemBuilder: (BuildContext bc) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem(child: Text('Opção 1'), value: '1',),
                PopupMenuItem(child: Text('Opção 2'), value: '2',),
                PopupMenuItem(child: Text('Opção 3'), value: '3',),
              ];
            },
          ),
        ),
        Image.asset(AppImages.user1, height: 100,),
        Image.asset(AppImages.user2, height: 100,),
        Image.asset(AppImages.user3, height: 100,),
        Image.asset(AppImages.paisagem1, width: double.infinity,),
        Image.asset(AppImages.paisagem2, width: double.infinity,),
        Image.asset(AppImages.paisagem3, width: double.infinity,),
      ],
    );
  }
}
