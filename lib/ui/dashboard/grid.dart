import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

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

Widget getDashboardSummaryWidget(
    {TextStyle numberStyle,
    TextStyle titleStyle,
    BuildContext context,
    String imagePath,
    Color imageColor,
    @required String title,
    @required int number}) {
  return ResponsiveBuilder(
    builder: (context, sizingInformation) {
      double imageSize = 24;
      double separator = 8;
      if (sizingInformation.isMobile) {
        imageSize = 24;
        separator = 24;
        if (numberStyle == null) {
          numberStyle = Styles.pinkBoldLarge;
        }
        if (titleStyle == null) {
          titleStyle = Styles.blackTiny;
        }
      }
      if (sizingInformation.isTablet) {
        imageSize = 24;
        separator = 16;
        if (numberStyle == null) {
          numberStyle = Styles.blueBoldMedium;
        }
        if (titleStyle == null) {
          titleStyle = Styles.blackTiny;
        }
      }
      if (sizingInformation.isDesktop) {
        imageSize = 24;
        separator = 24;
        if (numberStyle == null) {
          numberStyle = Styles.blueBoldLarge;
        }
        if (titleStyle == null) {
          titleStyle = Styles.blackTiny;
        }
      }
      return Card(
        child: Column(
          children: [
            SizedBox(height: separator),
            imagePath == null
                ? Image.asset(
                    'assets/logo.png',
                    color: imageColor == null ? Colors.black : imageColor,
                    width: imageSize,
                    height: imageSize,
                  )
                : Image.asset(
                    imagePath,
                    color: imageColor == null ? Colors.black : imageColor,
                    width: imageSize,
                    height: imageSize,
                  ),
            SizedBox(height: separator),
            Text(
              '$number',
              style: numberStyle == null ? Styles.blackBoldLarge : numberStyle,
            ),
            SizedBox(height: separator),
            Center(
              child: Text(title,
                  style: titleStyle == null ? Styles.blackSmall : titleStyle),
            ),
          ],
        ),
      );
    },
  );
}
