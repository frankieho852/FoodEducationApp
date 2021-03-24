import 'package:flutter/material.dart';

//unused for now
class VerificationPageSucceed extends StatefulWidget {
  final VoidCallback shouldShowLogin;

  VerificationPageSucceed({Key key, this.shouldShowLogin}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerificationPageSucceedState();
}

class _VerificationPageSucceedState extends State<VerificationPageSucceed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 40),
          child: Stack(children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 50.0,
            ),

            ElevatedButton(
              child: Text("Let's Go"),
              onPressed: widget.shouldShowLogin,
            ),
            // Sign Up Button
          ])),
    );
  }
}
