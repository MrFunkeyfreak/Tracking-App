import 'package:flutter/material.dart';
import '../../datamodels/navbar_item_model.dart';

// just defining the size of the TextStyle of the TopNavBarItem

class TopNavBarItemTablet extends StatelessWidget {
  final NavBarItemModel? model;
  const TopNavBarItemTablet({Key? key, this.model}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Text(
      model!.title!,
      style: const TextStyle(fontSize: 10),
    );
  }
}
