import 'package:flutter/material.dart';

class StaggeDualView extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double aspectRatio;
  final double spacing;

  const StaggeDualView(
      {super.key,
      required this.itemBuilder,
      required this.itemCount,
      this.aspectRatio = 0.5,
      this.spacing = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth;
        final itemHeigth = (width * 0.5) / aspectRatio;
        final heigth = constraints.maxHeight + itemHeigth;
        return OverflowBox(
          maxWidth: width,
          minWidth: width,
          maxHeight: heigth,
          minHeight: heigth,
          child: GridView.builder(
              padding: EdgeInsets.only(top: itemHeigth / 2, bottom: itemHeigth),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: aspectRatio,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
              ),
              itemCount: itemCount,
              itemBuilder: (BuildContext context, int index) {
                return Transform.translate(
                  offset: Offset(0.0, index.isOdd ? itemHeigth * 0.3 : 0.0),
                  child: itemBuilder(context, index),
                );
              }),
        );
      },
    );
  }
}
