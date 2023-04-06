import 'dart:async';

import 'package:alieample2/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MyStatefulWidget.dart';
class Splash extends StatefulWidget {
   Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _Splash();
}


class _Splash extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=> checkLogin()
    );
  }
  void checkLogin()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
     String? val = pref.getString("login");
    if( val!=null) {
     Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
         builder: (BuildContext context) {
            return const Welcome(

              title: '',             );
           },
         ),
             (raute) => false,
       );
   }
    else{
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const MyStatefulWidget(


            );
          },
        ),
            (raute) => false,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image : DecorationImage(image: AssetImage("assetts/new.gif"),
              fit: BoxFit.cover),
        ),
      //  child: Image.asset("assetts/exodus.gif" ,height: 1000,width: 700,)
    );
  }
}
