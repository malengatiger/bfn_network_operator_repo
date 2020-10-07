import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class DashboardGrid extends StatelessWidget implements GridListener {
  final List<Widget> widgets;
  final GridListener gridListener;
  final int crossAxisCount;
  final double mainAxisSpacing, crossAxisSpacing;

  const DashboardGrid(
      {Key key,
      @required this.widgets,
      @required this.gridListener,
      this.crossAxisCount,
      this.mainAxisSpacing,
      this.crossAxisSpacing})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    p('🔵🔵🔵 ...... create the GridView ....... ');
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount == null ? 2 : crossAxisCount,
          mainAxisSpacing: mainAxisSpacing == null ? 2 : mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing == null ? 2 : crossAxisSpacing),
      itemCount: widgets.length,
      itemBuilder: (BuildContext context, int index) {
        var item = widgets.elementAt(index);
        return item;
      },
    );
  }

  @override
  onGridItemTapped(int index) {
    p('DashboardGrid: 🔔🔔🔔 onGridItemTapped. telling listener ... 🔔 index: $index');
    if (gridListener != null) {
      gridListener.onGridItemTapped(index);
    }
  }
}

abstract class GridListener {
  onGridItemTapped(int index);
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
