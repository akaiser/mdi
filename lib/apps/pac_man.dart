import 'package:flutter/material.dart';
import 'package:mdi/apps/widgets/simple_grid_view.dart';

const xCount = 28;
const yCount = 31;

// @formatter:off
const borders = {
// ignore: lines_longer_than_80_chars
  0: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 13, 15,19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30],
  1: [0, 9, 13, 15, 19, 24, 25, 30],
  2: [0, 2, 3, 4, 6, 7, 9, 13, 15, 19, 21, 22, 27, 28, 30],
  3: [0, 2, 3, 4, 6, 7, 9, 13, 15, 19, 21, 22, 23, 24, 25, 27, 28, 30],
  4: [0, 2, 3, 4, 6, 7, 9, 13, 15, 19, 21, 22, 23, 24, 25, 27, 28, 30],
};
// @formatter:on

void main() {
  runApp(const MaterialApp(home: Scaffold(body: PacMan())));
}

class PacMan extends StatelessWidget {
  const PacMan();

  @override
  Widget build(BuildContext context) => SimpleGridView(
        columnCount: xCount,
        rowCount: yCount,
        cellBuilder: (context, xIndex, yIndex) {
          final border = borders[xIndex];
          if (border != null) {
            if (border.contains(yIndex)) {
              return  const SizedBox();
            }
          }
          return ColoredBox(
            color: Colors.black,
            child: Text('$xIndex:$yIndex'),
          );
        },
      );
}
