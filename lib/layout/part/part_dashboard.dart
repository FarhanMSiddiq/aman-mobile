import 'package:aman_mobile/layout/detail_perjadin.dart';
import 'package:aman_mobile/model/perjadin.dart';
import 'package:aman_mobile/model/user_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';


class PartDashboard extends StatefulWidget {
  final UserData userData;

  PartDashboard({Key? key, required this.userData}) : super(key: key);

  @override
  PartDashboardState createState() => PartDashboardState();
}


class PartDashboardState extends State<PartDashboard> {

  var perjadin = List<Perjadin>.empty(growable: true);
  bool isLoading = false;
  bool isLoadingCount = false;

  RecapPerjadin recap = RecapPerjadin(0,0,0,0);

  void initState(){
    loadData();
    loadDataRecap();
  }

  Widget setShimmerLoading(){
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 2,
      shrinkWrap: true,
      children: List.generate(6, (index) {
        return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 140.0,
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
      }),
    );
  }

  void loadData() async {
      isLoading = true;

      var dio = Dio();
      dio.options.connectTimeout = Duration(seconds: 20000); //20s
      dio.options.receiveTimeout = Duration(seconds: 20000);

      try {
          var getPerjadin = await dio.get('https://staging.impstudio.id/aman_pendampingan_jp/api/v1/mobile/dashboard/newest-perjadin',
          options: Options(
              headers: {
                "Content-Type" : "application/json",
                "Authorization" : "Bearer ${widget.userData.token}"
              },
            )
          );
          
          var dataListPerjadin = getPerjadin.data;


          for (var value in dataListPerjadin['data']) {
              perjadin.add(Perjadin(
                  value['id'],
                  value['id_perjadin'],
                  value['jenis_program'],
                  value['status'],
                  value['tgl_pendampingan'],
                  value['nama_kabupaten'],
                  value['nama_provinsi']
              ));
          }

      } catch (e) {
          print("Error disini ${e}");
      }

      isLoading = false;

      setState(() {});
  }


  void loadDataRecap() async {
      isLoadingCount = true;

      var dio = Dio();
      dio.options.connectTimeout = Duration(seconds: 20000); //20s
      dio.options.receiveTimeout = Duration(seconds: 20000);

      try {
          var getRecap = await dio.get('https://staging.impstudio.id/aman_pendampingan_jp/api/v1/mobile/dashboard/recap-perjadin',
          options: Options(
              headers: {
                "Content-Type" : "application/json",
                "Authorization" : "Bearer ${widget.userData.token}"
              },
            )
          );
          
          var dataRecap = getRecap.data;

          recap = RecapPerjadin(
            dataRecap['data']['recap_semua'],
            dataRecap['data']['recap_rencana'],
            dataRecap['data']['recap_terlaksana'],
            dataRecap['data']['recap_reclaim'],
          );

      } catch (e) {
          print("Error disini ${e}");
      }

      isLoadingCount = false;

      setState(() {});
  }

   Widget listPerjadin(){
    return Builder(builder: (BuildContext context) {
                      return GridView.builder(
                        itemCount: perjadin.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                                    onTap: (() {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPerjadinPage(
                                        idPerjadin: perjadin[index].idPerjadin,
                                        userData: widget.userData,
                                      )));
                                    }),
                                    child: Container(
                                                        padding: EdgeInsets.all(10),
                                                        width: MediaQuery.of(context).size.width,
                                                        margin: EdgeInsets.symmetric(horizontal: 5 , vertical: 10),
                                                        decoration: new BoxDecoration(
                                                          borderRadius: new BorderRadius.circular(10.0),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey.withOpacity(0.3),
                                                                spreadRadius: 3,
                                                                blurRadius: 7,
                                                                offset: Offset(0, 3), // changes position of shadow
                                                              ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                              Text("ID : ${perjadin[index].idPerjadin}",
                                                                style: TextStyle(
                                                                  color: Color(0xFF346D55),
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 16
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets.only(top: 20),
                                                                child: Stack(
                                                                  children: [
                                                                    Icon(Icons.account_tree_outlined  , size: 20 , color: Color(0xFF34AC69)) ,
                                                                    Container(
                                                                      margin: EdgeInsets.only(left: 30),
                                                                      child: Text("${perjadin[index].jenisProgram}",
                                                                        overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                        maxLines: 3,
                                                                        style: TextStyle(
                                                                          fontSize: 12
                                                                        ),
                                                                      ) ,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets.only(top: 10),
                                                                child: Stack(
                                                                  children: [
                                                                    Icon(Icons.pin_drop  , size: 20 , color: Color(0xFF34AC69)) ,
                                                                    Container(
                                                                      margin: EdgeInsets.only(left: 30),
                                                                      child: Text("${perjadin[index].namaKabupaten} , ${perjadin[index].namaProvinsi}",
                                                                        overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                        maxLines: 2,
                                                                        style: TextStyle(
                                                                          fontSize: 12
                                                                        ),
                                                                      ) ,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets.only(top: 10),
                                                                child: Stack(
                                                                  children: [
                                                                    Icon(Icons.calendar_month  , size: 20 , color: Color(0xFF34AC69)) ,
                                                                    Container(
                                                                      margin: EdgeInsets.only(left: 30 , top: 2),
                                                                      child: Text("${perjadin[index].tglPendampingan}",
                                                                        overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                        maxLines: 1,
                                                                        style: TextStyle(
                                                                          fontSize: 12
                                                                        ),
                                                                      ) ,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets.only(top:10),
                                                                child: Badge(
                                                                  backgroundColor: Color(0xFF34AC69),
                                                                  label: Text("${perjadin[index].status}"),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                  ),
                                );
                        },
                      );
                    }
                  );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text("Dashboard",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width/2.4,
                    decoration: new BoxDecoration(
                      borderRadius:
                      new BorderRadius.circular(16.0),
                      color: Color(0xFF2961F2),
                    ),
                    child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Icon(Icons.calendar_today_rounded,color: Colors.white,size: 40,),
                              ),
                              Text("Semua Perjadin",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                child: (isLoadingCount) ? Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: CircularProgressIndicator(color: Color.fromARGB(255, 185, 196, 255)),
                                ) : Text("${recap.recapSemua}",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 185, 196, 255),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ],
                          )
                  ),
                  Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width/2.4,
                    decoration: new BoxDecoration(
                      borderRadius:
                      new BorderRadius.circular(16.0),
                      color: Color(0xFFF4A100),
                    ),
                    child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Icon(Icons.calendar_today_rounded,color: Colors.white,size: 40,),
                              ),
                              Text("Rencana Perjadin",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                child: (isLoadingCount) ? Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: CircularProgressIndicator(color: Color.fromARGB(255, 255, 229, 185)),
                                ) : Text("${recap.recapRencana}",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 229, 185),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ],
                          )
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width/2.4,
                    decoration: new BoxDecoration(
                      borderRadius:
                      new BorderRadius.circular(16.0),
                      color: Color(0xFF34AC69),
                    ),
                    child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Icon(Icons.calendar_today_rounded,color: Colors.white,size: 40,),
                              ),
                              Text("Terlaksana",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                child: (isLoadingCount) ? Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: CircularProgressIndicator(color: Color.fromARGB(255, 185, 255, 186)),
                                ) : Text("${recap.recapTerlaksana}",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 185, 255, 186),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ],
                          )
                  ),
                  Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width/2.4,
                    decoration: new BoxDecoration(
                      borderRadius:
                      new BorderRadius.circular(16.0),
                      color: Color(0xFFE81500),
                    ),
                    child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Icon(Icons.calendar_today_rounded,color: Colors.white,size: 40,),
                              ),
                              Text("Semua Reclaim",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                child: (isLoadingCount) ? Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: CircularProgressIndicator(color: Color.fromARGB(255, 255, 185, 185)),
                                ) : Text("${recap.recapReclaim}",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 185, 185),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          )
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20,bottom: 20),
              child: Text("10 Permohonan Terbaru",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            ),
            Container(
              child: (isLoading) ? setShimmerLoading() : listPerjadin(),
            )
          ]
        ),
      ),
    );
  }
}