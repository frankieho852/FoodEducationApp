import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/dailyintake.dart';
class Minmaxbar extends StatelessWidget {
  const Minmaxbar({
    Key key,
    @required this.daily,
    @required this.size,
    @required this.total,
  }) : super(key: key);
  final DailyIntake daily;
  final Size size;
  final double total;
  @override
  Widget build(BuildContext context) {
    double percent=1;
    if(daily.maxSametype!=0){
      percent=(total-daily.minSametype)/(daily.maxSametype-daily.minSametype);
    }
    double resize=1;//this is for resize if the bar is on left edge or right edge
    if(percent>0.97||percent<0.03){resize=3;}
    if(percent>0.98||percent<0.02){resize=4;}
    if(percent==1||percent==0){resize=5;}

    return CustomPaint(
      child: Container(
        color: Colors.transparent,
        // child: Text("hehexd"),
      ),
      painter: TempPainter(percent,resize),
    );
  }
}

class TempPainter extends CustomPainter {
  double percent;
  double resize;
  TempPainter(this.percent,this.resize);
  @override
  void paint(Canvas canvas, Size size) {
    // Offset center = Offset(size.width / 2, size.height / 2);
    // Rect rect = Rect.fromCircle(center: center, radius: size.width / 2);

    //Color(0xff004d40)
    Paint Paint1 = Paint()
      ..color = kPrimaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height;//the bar are resized by the container size
    Paint Paint2 = Paint()
      ..color = Color(0xff004d40)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    final p1 = Offset(size.width*0.04, size.height/2);
    final p2 = Offset(size.width*0.96, size.height/2);

    final p3 = Offset(size.width*percent, size.height*0.1*resize);
    final p4 = Offset(size.width*percent, size.height*(1-(resize*0.1)));

    canvas.drawLine(p1,p2,Paint1);
    canvas.drawLine(p3,p4,Paint2);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}