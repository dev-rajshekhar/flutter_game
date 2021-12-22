import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_game/paint/custom_paint.dart';
import 'package:flutter_game/paint/point_holder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    void setStrokeWidth(double i) {
      setState(() {
        strokeWidth = i;
      });
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Paint Game'),
        ),
        body: Column(
          children: [
            buildGestureView(context),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PaintIcon(
                    defaultSelectedColor: selectedColor,
                    icon: Icons.color_lens,
                    isSelected: true,
                    onTap: () {
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
                                    selectedIndex = 0;
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          });
                    },
                  ),
                  PaintIcon(
                    defaultSelectedColor: selectedColor,
                    isSelected: selectedIndex == 1,
                    onTap: () {
                      setStrokeWidth(3);
                      selectedIndex = 1;
                    },
                    icon: Icons.brush,
                  ),
                  PaintIcon(
                    defaultSelectedColor: selectedColor,
                    isSelected: selectedIndex == 2,
                    onTap: () {
                      setStrokeWidth(30);
                      selectedIndex = 2;
                    },
                    icon: FontAwesomeIcons.paintBrush,
                  ),
                  PaintIcon(
                    isSelected: selectedIndex == 3,
                    onTap: () {
                      setState(() {
                        strokeWidth = 30.0;
                        selectedColor = Colors.white;
                        selectedIndex = 3;
                      });
                    },
                    icon: FontAwesomeIcons.eraser,
                  ),
                  PaintIcon(
                    isSelected: selectedIndex == 4,
                    onTap: () {
                      setState(() {
                        points.clear();
                        selectedIndex = 4;
                        selectedColor = Colors.red;
                        setStrokeWidth(3);
                      });
                    },
                    icon: FontAwesomeIcons.trash,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  GestureDetector buildGestureView(BuildContext context) {
    return GestureDetector(
      onPanEnd: (details) {
        setState(() {
          points.add(null);
        });
      },
      onPanUpdate: onPanUpdate,
      onPanStart: onPanStatrt,
      child: RepaintBoundary(
        child: CustomPaint(
          isComplex: true,
          willChange: false,
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.6),
          painter: PaintView(pointsList: points),
        ),
      ),
    );
  }

  onPanStatrt(DragStartDetails details) {
    setState(() {
      RenderBox renderBox = context.findRenderObject() as RenderBox;
      points.add(PointHolder(
          points: renderBox.globalToLocal(details.localPosition),
          paint: Paint()
            ..strokeCap = strokeType
            ..isAntiAlias = true
            ..color = selectedColor
            ..strokeWidth = strokeWidth));
    });
  }

  onPanUpdate(DragUpdateDetails details) {
    setState(() {
      RenderBox renderBox = context.findRenderObject() as RenderBox;

      if (details.localPosition.dy < MediaQuery.of(context).size.height * 0.6) {
        points.add(
          PointHolder(
              points: renderBox.globalToLocal(details.localPosition),
              paint: Paint()
                ..strokeCap = strokeType
                ..isAntiAlias = true
                ..color = selectedColor
                ..strokeWidth = strokeWidth),
        );
      }
    });
  }
}

class PaintIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;
  final Color defaultSelectedColor;

  const PaintIcon(
      {Key? key,
      required this.icon,
      required this.onTap,
      required this.isSelected,
      this.defaultSelectedColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: FaIcon(
        icon,
        color: isSelected ? defaultSelectedColor : Colors.grey,
      ),
    );
  }
}
