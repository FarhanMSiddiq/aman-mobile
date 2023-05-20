import 'package:aman_mobile/layout/widget/dialog_msg.dart';
import 'package:aman_mobile/model/notifikasi.dart';
import 'package:aman_mobile/model/user_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';


class PartNotification extends StatefulWidget {
  final UserData userData;

  PartNotification({Key? key, required this.userData}) : super(key: key);

  @override
  PartNotificationState createState() => PartNotificationState();
}


class PartNotificationState extends State<PartNotification> {

  var notifikasi = List<Notifikasi>.empty(growable: true);
  bool isLoading = false;
  int page = 1;
  ScrollController scrollController = new ScrollController();
  
  void initState(){
    loadData();

     scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          loadData();
      }
    });
  }


  void loadData() async {
      setState(() {
        isLoading = true;
      });

      var dio = Dio();
      dio.options.connectTimeout = Duration(seconds: 20000); //20s
      dio.options.receiveTimeout = Duration(seconds: 20000);

      try {
          var getNotifikasi = await dio.get('https://staging.impstudio.id/aman_pendampingan_jp/api/v1/mobile/notifikasi?page=${page}',
          options: Options(
              headers: {
                "Content-Type" : "application/json",
                "Authorization" : "Bearer ${widget.userData.token}"
              },
            )
          );
          
          var dataListNotifikasi = getNotifikasi.data;

          print(dataListNotifikasi);


          for (var value in dataListNotifikasi['data']['data']) {
              notifikasi.add(Notifikasi(
                  value['id'],
                  value['title'],
                  value['description'],
                  value['is_read'] ?? 0,
                  value['created_at']
              ));
          }

          page++;
          

      } catch (e) {
          print("Error disini ${e}");
      }

      setState(() {
        isLoading = false;
      });
  }

  void readNotif(int id) async {

      var dio = Dio();
      dio.options.connectTimeout = Duration(seconds: 20000); //20s
      dio.options.receiveTimeout = Duration(seconds: 20000);

      try {
          var readNotif = await dio.post('https://staging.impstudio.id/aman_pendampingan_jp/api/v1/mobile/notifikasi/read/${id}',
          options: Options(
              headers: {
                "Content-Type" : "application/json",
                "Authorization" : "Bearer ${widget.userData.token}"
              },
            )
          );

          if(readNotif.statusCode==200){
            notifikasi.clear();
            setState(() {
              page = 1;
            });
            loadData();
          }

      } catch (e) {
          print("Error disini ${e}");
      }
  }


   Widget setShimmerLoading(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 15,
      itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: new EdgeInsets.symmetric(horizontal : 10),
              child : SizedBox(
                height: 70,
                child: Shimmer.fromColors(
                  baseColor: Color(0xFFDCDCDC),
                  highlightColor: Color(0xFFD3D3D3),
                  child: Container(
                    padding: new EdgeInsets.all(4),
                    decoration: BoxDecoration(
                              color: Color(0xFFE9E9E9),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10)
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 20,
                                  color:  Color(0xFFE9E9E9),
                                ),
                              ],
                            ),
                      )
                  )
                )
              ),
          );
        }
    );

  }

   Widget buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

   Widget listNotif(){
    return Builder(builder: (BuildContext context) {
                      return ListView.builder(
                        itemCount: notifikasi.length + 1,
                        itemBuilder: (context, index) {
                          if(index == notifikasi.length){
                            return buildProgressIndicator();
                          }else{
                            return Column(
                              children: [
                                InkWell(
                                    onTap: (() {
                                      showMsgDialog(context, notifikasi[index].title, notifikasi[index].description);
                                      readNotif(notifikasi[index].id);
                                    }),
                                    child: Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        padding: EdgeInsets.symmetric(vertical: 10),
                                                        color: (notifikasi[index].isRead!=1) ? Colors.white : Colors.transparent,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets.symmetric(horizontal: 20),
                                                              child: Text(notifikasi[index].title,
                                                                style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.only(top: 5),
                                                              padding: EdgeInsets.symmetric(horizontal: 20),
                                                              child: Text(notifikasi[index].description,
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.only(top: 5),
                                                              padding: EdgeInsets.symmetric(horizontal: 20),
                                                              child: Text(notifikasi[index].createdAt,
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color.fromARGB(255, 120, 116, 116)
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: Color.fromARGB(255, 214, 215, 214),
                                  thickness: 1.0,
                                )
                              ],
                            );
                          }
                        },
                        controller: scrollController
                      );
                    }
                  );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20,top: 30),
              child: Text("Notifikasi",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 80),
              child: (isLoading && page==1) ?  setShimmerLoading() : SizedBox(child: listNotif()),
            )
          ]
        )
    );
  }
}