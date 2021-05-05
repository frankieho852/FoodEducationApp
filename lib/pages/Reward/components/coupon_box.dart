import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
class CouponBox extends StatelessWidget {
  const CouponBox({
    Key key,
    this.coupon,
  }) : super(key: key);

  final String coupon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Container(
          height: size.height*0.05,
          width: size.width*0.4,
          //color: Colors.red,
          child: Column(
            children: [
              Text("COIN",style: TextStyle(fontSize: 14),),
              Flexible(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: FittedBox(child: Text(coupon,style: TextStyle(fontSize: 20),))),
                      SizedBox(width: 4,),
                      Container(child: SvgPicture.asset("assets/icons/currency.svg"))

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
