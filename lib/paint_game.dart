import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class PaintGame extends StatefulWidget {
  const PaintGame({Key? key}) : super(key: key);

  @override
  _PaintGameState createState() => _PaintGameState();
}

class _PaintGameState extends State<PaintGame> {
  List<PointHolder?> points = <PointHolder?>[];
  double opacity = 1.0;
  StrokeCap strokeType = StrokeCap.round;
  double strokeWidth = 3.0;
  Color selectedColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    onPanStatrt(DragStartDetails details) {
      setState(() {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        points.add(PointHolder(
            points: renderBox.globalToLocal(details.localPosition),
            paint: Paint()
              ..strokeCap = strokeType
              ..isAntiAlias = true
              ..color = selectedColor.withOpacity(opacity)
              ..strokeWidth = strokeWidth));
      });
    }

    onPanUpdate(DragUpdateDetails details) {
      setState(() {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        points.add(PointHolder(
            points: renderBox.globalToLocal(details.localPosition),
            paint: Paint()
              ..strokeCap = strokeType
              ..isAntiAlias = true
              ..color = selectedColor.withOpacity(opacity)
              ..strokeWidth = strokeWidth));
      });
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Paint Game'),
        ),
        body: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {},
              onPanEnd: (details) {
                setState(() {
                  points.add(null);
                });
              },
              onPanUpdate: onPanUpdate,
              onPanStart: onPanStatrt,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height * 0.6),
                painter: PaintView(pointsList: points),
              ),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.color_lens),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Select Color'),
                              content: BlockPicker(
                                pickerColor: selectedColor,
                                onColorChanged: (color) {
                                  setState(() {
                                    selectedColor = color;
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          });
                    },
                  ),
                  IconButton(
                    iconSize: 20,
                    onPressed: () {
                      setState(() {
                        strokeWidth = 3.0;
                      });
                    },
                    icon: const Icon(Icons.brush),
                  ),
                  IconButton(
                    iconSize: 40,
                    onPressed: () {
                      setState(() {
                        strokeWidth = 30.0;
                      });
                    },
                    icon: const Icon(Icons.brush),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        strokeWidth = 30.0;
                        selectedColor = Colors.white;
                      });
                    },
                    icon: Icon(Icons.phonelink_erase_rounded),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        points.clear();
                      });
                    },
                    icon: const Icon(Icons.clear_all),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

//Paint Classs to draw
class PaintView extends CustomPainter {
  List<PointHolder?> pointsList;
  List<Offset> offsetPoints = [];

  PaintView({required this.pointsList});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        //Drawing line when two consecutive points are available
        canvas.drawLine(pointsList[i]!.points, pointsList[i + 1]!.points,
            pointsList[i]!.paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i]!.points);
        offsetPoints.add(Offset(
            pointsList[i]!.points.dx + 0.1, pointsList[i]!.points.dy + 0.1));

        //Draw points when two points are not next to each other
        canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i]!.paint);
      }
    }
  }

  @override
  bool shouldRepaint(PaintView oldDelegate) {
    return true;
  }
}

class PointHolder {
  Paint paint;
  Offset points;
  PointHolder({required this.points, required this.paint});
}
