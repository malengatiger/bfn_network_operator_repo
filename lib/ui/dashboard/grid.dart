import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

import 'card.dart';

class DashboardGrid extends StatelessWidget implements GridListener {
  final List<Item> items;
  final GridListener gridListener;

  const DashboardGrid(
      {Key key, @required this.items, @required this.gridListener})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    p('create the GridView ....... ');
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 2, crossAxisSpacing: 2),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        var item = items.elementAt(index);
        return DashboardCard(
          item: item,
          gridListener: this,
        );
      },
    );
  }

  @override
  onGridItemTapped(Item item) {
    p('DashboardGrid: 🔔🔔🔔 onGridItemTapped. telling listener ... 🔔 ${item.title} ${item.number}');
    if (gridListener != null) {
      gridListener.onGridItemTapped(item);
    }
  }
}

abstract class GridListener {
  onGridItemTapped(Item item);
}

class Item {
  final String title, number;
  final double titleSize, numberSize, cardWidth;
  final TextStyle titleStyle, numberStyle;

  Item(
      {this.title,
      this.number,
      this.titleSize,
      this.numberSize,
      this.cardWidth,
      this.titleStyle,
      this.numberStyle});
}
