import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:food_education_app/dailyintake.dart';
class Minmaxbar extends StatelessWidget {
  const Minmaxbar({
    Key key,
    @required this.daily,
  }) : super(key: key);
  final DailyIntake daily;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomPaint(
      child: Container(
        height: size.height*0.18,
        width: size.width*0.18,
      ),
      painter: TempPainter(daily.maxSametype,daily.minSametype),
    );
  }
}

class TempPainter extends CustomPainter {
  double minSametype;
  double maxSametype;
  double proteinDegree=0;
  TempPainter(this.maxSametype, this.minSametype);
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    Rect rect = Rect.fromCircle(center: center, radius: size.width / 2);


    Paint proteinPaint = Paint()
      ..color = Color(0xFF8245CF)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;
    final p1 = Offset(0, 0);
    final p2 = Offset(size.width*0.5, 0);
    canvas.drawLine(p1,p2,proteinPaint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //todo: what is the appropriate value for this?
    return true;
  }
}