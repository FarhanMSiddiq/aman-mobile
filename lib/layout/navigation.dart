import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aman_mobile/layout/part/part_dashboard.dart';
import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:badges/badges.dart' as badges;
import 'package:aman_mobile/layout/part/part_permohonan.dart';
import 'package:aman_mobile/layout/part/part_notification.dart';
import 'package:aman_mobile/layout/part/part_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aman_mobile/model/user_data.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}


class _NavigationPageState extends State<NavigationPage> {

  SharedPreferences? prefs ;
  UserData? userData;

  int statePage = 0;
  int countNotif = 0;

  Widget page = Container();


  void initState(){
    getSession();
  }


  void getSession() async{
    prefs = await SharedPreferences.getInstance();
    userData = UserData(prefs);
    setState(() {});
    loadDataNotification();
  }

  Widget pageNow(BuildContext context){
    final GlobalKey<PartDashboardState> _keyDashboard = GlobalKey();
    final GlobalKey<PartPermohonanState> _keyPermohonan = GlobalKey();
    final GlobalKey<PartNotificationState> _keyNotification = GlobalKey();
    final GlobalKey<PartProfileState> _keyProfile = GlobalKey();

    if(statePage==0){
      if(prefs!=null){
        return PartDashboard(key: _keyDashboard, userData : UserData(prefs));
      }else{
        return Container();
      }
    }else if(statePage==1){
      return PartPermohonan(key: _keyPermohonan, userData : UserData(prefs));
    }else if(statePage==2){
      return PartNotification(key: _keyNotification,userData : UserData(prefs));
    }else if(statePage==3){
      return PartProfile(key: _keyProfile,userData : UserData(prefs));
    }else{
      return Center(
        child: Text("Halaman Tidak Ditemukan."),
      );
    }
  }

  void loadDataNotification() async {

      var dio = Dio();
      dio.options.connectTimeout = Duration(seconds: 20000); //20s
      dio.options.receiveTimeout = Duration(seconds: 20000);

      try {
          var getNotifCount = await dio.get('https://staging.impstudio.id/aman_pendampingan_jp/api/v1/mobile/notifikasi/newest-count',
          options: Options(
              headers: {
                "Content-Type" : "application/json",
                "Authorization" : "Bearer ${userData!.token}"
              },
            )
          );
          
          var dataNotifCount = getNotifCount.data;

          setState(() {
            countNotif = dataNotifCount['data']['newest_count'];
          });

      } catch (e) {
          print("Error disini ${e}");
      }
      
  }
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF2F6FC),
      appBar: AppBar(
        title: Text('AMAN 2.0',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
            Container(
              margin: EdgeInsets.only(right: 20),
              child: IconButton(icon: 
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: (userData!.pathFoto!="") ? Image.network(userData!.pathFoto.replaceAll('aman-madrasah-staging', 'aman-madrasah')) : 
                  Image.asset('lib/images/ic_user.png'),
                )

              , onPressed: () {
                setState(() {
                  statePage = 3;
                });
              }),
            )
        ],
      ),
      body: pageNow(context),
      bottomNavigationBar: BottomBarBubble(
        selectedIndex: statePage,
        items: [
         BottomBarItem(iconData: Icons.home_filled),
         BottomBarItem(iconData: Icons.mail_outline),
         BottomBarItem(iconBuilder: (Color color){
          if(countNotif>0){
            return badges.Badge(
              badgeContent: Text('${countNotif}',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              child: Icon(Icons.notifications_none,size: 30,color: color),
            );
          }else{
            return Icon(Icons.notifications_none,size: 30,color: color);
          }
          
         }),
         BottomBarItem(iconData: Icons.manage_accounts),
        ],
        onSelect: (index) {
            setState(() {
              statePage = index;
            });
        },
      ),
    );
  }

}