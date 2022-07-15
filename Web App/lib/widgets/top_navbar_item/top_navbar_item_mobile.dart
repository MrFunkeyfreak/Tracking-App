import 'package:flutter/material.dart';
import '../../datamodels/navbar_item_model.dart';

// just defining the size of the TextStyle of the TopNavBarItem in mobile size (sidemenu)

class TopNavBarItemMobile extends StatelessWidget {
  final NavBarItemModel? model;
  const TopNavBarItemMobile({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 30),
      child: Row(
        children: <Widget>[
          Icon(model!.iconData),
          const SizedBox(
            width: 30,
          ),
          Text(
            model!.title!,
            style: const TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}
