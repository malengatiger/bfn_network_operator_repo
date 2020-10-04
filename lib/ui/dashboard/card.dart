import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'grid.dart';

class DashboardCard extends StatelessWidget {
  final Item item;
  final double titleSize, numberSize, cardWidth;
  final TextStyle titleStyle, numberStyle;
  final GridListener gridListener;

  const DashboardCard(
      {Key key,
      @required this.item,
      this.titleSize,
      this.numberSize,
      this.titleStyle,
      this.numberStyle,
      @required this.gridListener,
      this.cardWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          p('The 🔵 🔵 🔵 fucking GestureDetector has fired an onTap event 🔵');
          if (gridListener != null) {
            gridListener.onGridItemTapped(item);
          }
        },
        child: Container(
          width: cardWidth == null ? 220.0 : cardWidth,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(item.title,
                    style: titleStyle == null ? Styles.blackSmall : titleStyle),
                SizedBox(height: 20),
                Text(
                  item.number,
                  style:
                      numberStyle == null ? Styles.blackBoldLarge : numberStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
