import 'dart:async';

import 'package:aman_mobile/layout/login.dart';
import 'package:aman_mobile/layout/navigation.dart';
import 'package:aman_mobile/layout/widget/snackbar.dart';
import 'package:aman_mobile/model/user_data.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key, required this.title});

  final String title;

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}



class _SplashScreenPageState extends State<SplashScreenPage> {


  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      return checkLogin();
    }
    );
  }

  void checkLogin() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    UserData userData = UserData(prefs);

    userData.loadData();
    
    if(userData.token.isNullOrEmpty() || userData.tokenExpired <= DateTime.now().millisecondsSinceEpoch) {
      userData.clear();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage(title: 'Login')));
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NavigationPage()));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF0F8245),
      appBar: AppBar(
        title: Text(widget.title),
        toolbarHeight: 0,
      ),
      body: Center(
        child: Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.7),
              child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('lib/images/logo.png',width: 100),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text("AMAN",
                                style: TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                                textAlign: TextAlign.left,
                              ),
                              ),
                              Text("Aplikasi Manajemen Perjalanan Dinas",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: CircularProgressIndicator(color: Colors.white,),
                              )
                            ],
                )
          ),
      )
    );
  }

}