import 'package:flutter/material.dart';

import '../custom_components/app_images.dart';

class ListViewHorizontal extends StatefulWidget {
  const ListViewHorizontal({Key? key}) : super(key: key);

  @override
  State<ListViewHorizontal> createState() => _ListViewHorizontalState();
}

class _ListViewHorizontalState extends State<ListViewHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Card(child: Image.asset(AppImages.paisagem2,  height: 100,)),
              Card(child: Image.asset(AppImages.paisagem2,  height: 100,)),
              Card(child: Image.asset(AppImages.paisagem2,  height: 100,)),
            ],
          ),
        ),
        Expanded(flex: 3, child: Container())
      ],
    );
  }
}
