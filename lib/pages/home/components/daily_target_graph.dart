import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class DailyTargetGraph extends StatefulWidget {
  @override
  _DailyTargetGraphState createState() => _DailyTargetGraphState();
}

class _DailyTargetGraphState extends State<DailyTargetGraph>
    with SingleTickerProviderStateMixin {
  AnimationController _donutAnimationController;
  Animation<double> _donutAnimation;

  // todo: variable naming convention?
  double carbDegree = 0;
  double proteinDegree = 0;
  double fatDegree = 0;

  @override
  void initState() {
    super.initState();
    _donutAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _donutAnimation =
        Tween(begin: 0.0, end: 360.0).animate(_donutAnimationController)
          ..addListener(() {
            setState(() {
              carbDegree = 0.45 * _donutAnimation.value;
              proteinDegree = 0.3 * _donutAnimation.value;
              fatDegree = 0.25 * _donutAnimation.value;
            });
          });

    _donutAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        // todo: doesn't container by default take up the max space of its parent? why do we have to specify width and height here?

        height: 100,
        width: 100,
      ),
      painter: DonutPainter(carbDegree, proteinDegree, fatDegree),
    );
  }
}

class DonutPainter extends CustomPainter {
  double carbDegree;
  double proteinDegree;
  double fatDegree;
  DonutPainter(this.carbDegree, this.proteinDegree, this.fatDegree);
  @override
  void paint(Canvas canvas, Size size) {
    Paint carbPaint = Paint()
      ..color = Color(0xFFF38134)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Offset center = Offset(size.width / 2, size.height / 2);

    Rect rect = Rect.fromCircle(center: center, radius: size.width / 2);

    canvas.drawArc(
        rect, math.radians(-90), math.radians(carbDegree), false, carbPaint);

    Paint proteinPaint = Paint()
      ..color = Color(0xFF8245CF)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawArc(rect, math.radians(-90 + carbDegree),
        math.radians(proteinDegree), false, proteinPaint);

    Paint fatPaint = Paint()
      ..color = Color(0xFF1B70BE)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawArc(rect, math.radians(-90 + carbDegree + proteinDegree),
        math.radians(fatDegree), false, fatPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //todo: what is the appropriate value for this?
    return true;
  }
}
