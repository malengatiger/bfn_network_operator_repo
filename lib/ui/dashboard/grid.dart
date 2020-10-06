import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

import 'card.dart';

class DashboardGrid extends StatelessWidget implements GridListener {
  final List<Item> items;
  final GridListener gridListener;
  final int crossAxisCount, mainAxisSpacing, crossAxisSpacing;

  const DashboardGrid(
      {Key key,
      @required this.items,
      @required this.gridListener,
      this.crossAxisCount,
      this.mainAxisSpacing,
      this.crossAxisSpacing})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    p('create the GridView ....... ');
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount == null ? 2 : crossAxisCount,
          mainAxisSpacing: mainAxisSpacing == null ? 2 : mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing == null ? 2 : crossAxisSpacing),
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
  final double cardWidth;
  final TextStyle titleStyle, numberStyle;

  Item(
      {this.title,
      this.number,
      this.cardWidth,
      this.titleStyle,
      this.numberStyle});
}
