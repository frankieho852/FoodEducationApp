import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_education_app/constants.dart';
import 'uploadpic.dart';
class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String userImage="https://firebasestorage.googleapis.com/v0/b/food-education-383e1.appspot.com/o/userIcon%2FgCkxuSBuHATMXn8Zks3VfuEtSs03?alt=media&token=c55a121b-1666-44c0-b516-c945364e3adf";
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: userImage,
            imageBuilder: (context, imageProvider) => Container(
              //padding: EdgeInsets.all(kDefaultPadding * 0.1),
              height: size.height * 0.06,
              width: size.height * 0.06, // ensure sqaure container
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                image: DecorationImage(
                  image: NetworkImage(userImage),
                  //imageProvider
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
                alignment: Alignment.center,
                height: size.height * 0.06,
                width: size.height * 0.06,
                child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        kPrimaryColor))),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),

          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  backgroundColor: Color(0xFFF5F6F9),
                  primary: Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadPic(
                          )));
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
