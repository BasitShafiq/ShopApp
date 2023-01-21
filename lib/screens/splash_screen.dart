import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../providers/authenticate.dart';
import 'package:provider/provider.dart';
import './products_overview_screen.dart';
import './auth_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('images/1.png'),
            width: 350,
          ),
          SizedBox(
            width: 60,
            child: SpinKitSquareCircle(
              color: Colors.orange,
              size: 50.0,
            ),
          ),
        ],
      ),
    ));
  }
}
