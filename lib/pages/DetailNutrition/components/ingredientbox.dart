import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';

class IngredientBox extends StatelessWidget {
  const IngredientBox({
    Key key,
    @required this.size,
    @required this.ingredient,
  }) : super(key: key);

  final Size size;
  final List<String> ingredient;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.2,
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3.7),
              blurRadius: 14,
              color: Colors.black.withOpacity(0.08),
            ),
          ]),
      child: Column(children: [
        Text(
          "INGREDIENTS",
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(
          height: 1,
          width: double.infinity,
          child: const DecoratedBox(
              decoration: const BoxDecoration(color: Colors.grey)),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            padding: const EdgeInsets.only(top: 1, bottom: 1),
            color: Colors.transparent,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 1,
                childAspectRatio: (size.width * 0.5 / (50)),// this enable small device to view 2 line
              ),
              scrollDirection: Axis.vertical,
              itemCount: ingredient.length,
              itemBuilder: (BuildContext context, int index) => Container(
                color: Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 4),
                      //height: size.height * 0.01, //assume 2 row for text
                      width: 7,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ingredient[index],
                        maxLines:2,//if more than 2 line it will overflow
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
