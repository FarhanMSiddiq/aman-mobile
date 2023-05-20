import 'package:aman_mobile/layout/detail_perjadin.dart';
import 'package:aman_mobile/model/perjadin.dart';
import 'package:aman_mobile/model/user_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:select_form_field/select_form_field.dart';


class PartPermohonan extends StatefulWidget {
  final UserData userData;

  PartPermohonan({Key? key, required this.userData}) : super(key: key);

  @override
  PartPermohonanState createState() => PartPermohonanState();
}


class PartPermohonanState extends State<PartPermohonan> {

  var perjadin = List<Perjadin>.empty(growable: true);
  bool isLoading = false;
  ScrollController scrollController = new ScrollController();
  int page = 1;
  String keyword = "";
  String status = "";


  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  void initState(){
    loadData();
    
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          loadData();
      }
    });
  }

  Widget buildProgressIndicator() {
    return new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: new EdgeInsets.only(left: 10),
              child : SizedBox(
                width: 160.0,
                height: 120.0,
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
          )
      );
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
      setState(() {
        isLoading = true;
      });

      var dio = Dio();
      dio.options.connectTimeout = Duration(seconds: 20000); //20s
      dio.options.receiveTimeout = Duration(seconds: 20000);

      try {
          var getPerjadin = await dio.get('https://staging.impstudio.id/aman_pendampingan_jp/api/v1/mobile/permohonan?page=${page}${keyword}${status}',
          options: Options(
              headers: {
                "Content-Type" : "application/json",
                "Authorization" : "Bearer ${widget.userData.token}"
              },
            )
          );
          
          var dataListPerjadin = getPerjadin.data;

          print('https://staging.impstudio.id/aman_pendampingan_jp/api/v1/mobile/permohonan?page=${page}${keyword}${status}');

          for (var value in dataListPerjadin['data']['data']) {
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

          page++;


      } catch (e) {
          print("Error disini ${e}");
      }

      setState(() {
        isLoading = false;
      });
  }


   Widget listPerjadin(){
    return Builder(builder: (BuildContext context) {
                      return GridView.builder(
                        itemCount: perjadin.length + 2,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8
                        ),
                        itemBuilder: (context, index) {
                          if(index == perjadin.length){
                            return buildProgressIndicator();
                          }else if(index == perjadin.length+1){
                            return buildProgressIndicator();
                          }else{
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
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Container(
              margin: EdgeInsets.only(top: 30),
              child: Text("Daftar Permohonan",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
          ),
          Container(
            margin: EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(            
                                      width: MediaQuery.of(context).size.width*0.45,
                                      margin: EdgeInsets.only( bottom: 15),
                                      decoration: BoxDecoration(
                                                                  color: Color(0xFFFFFFFF),
                                                                  borderRadius: BorderRadius.circular(20),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors.grey.withOpacity(0.3),
                                                                      spreadRadius: 3,
                                                                      blurRadius: 7,
                                                                      offset: Offset(0, 3), // changes position of shadow
                                                                    ),
                                                                  ],
                                                                ),
                                      child: TextFormField(
                                                textInputAction: TextInputAction.search,
                                                onFieldSubmitted : (val){
                                                  perjadin.clear();
                                                  if(val!=""){
                                                      setState(() {
                                                        keyword = "&keyword=${val}";
                                                        page = 1;
                                                      });
                                                  }else{
                                                     setState(() {
                                                        keyword = "";
                                                        page = 1;
                                                      });
                                                  }
                                                  loadData();
                                                },
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(
                                                        horizontal: 10, vertical: 15),
                                                    prefixIcon: Icon(Icons.search),
                                                    border: InputBorder.none,
                                                    hintText: 'Cari data sini...',
                                                    hintStyle: TextStyle(
                                                      fontSize: 12
                                                    )),
                                            )
                ),
                Container(
                                      width: MediaQuery.of(context).size.width*0.40,
                                        margin: EdgeInsets.only(bottom: 15),
                                        decoration: BoxDecoration(
                                                                    color: Color(0xFFFFFFFF),
                                                                    borderRadius: BorderRadius.circular(20),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors.grey.withOpacity(0.3),
                                                                        spreadRadius: 3,
                                                                        blurRadius: 7,
                                                                        offset: Offset(0, 3), // changes position of shadow
                                                                      ),
                                                                    ],
                                                                  ),
                                        child: SelectFormField(
                                                  type: SelectFormFieldType.dialog,
                                                  onChanged : (val){
                                                    perjadin.clear();
                                                    if(val!=""){
                                                        setState(() {
                                                          status = "&status=${val}";
                                                          page = 1;
                                                        });
                                                    }else{
                                                      setState(() {
                                                          status = "";
                                                          page = 1;
                                                        });
                                                    }
                                                    loadData();
                                                  },
                                                  labelText: 'Pilih Status',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  enableSearch: true,
                                                  dialogSearchHint: 'Cari Status',
                                                  items: [
                                                     {
                                                      'value': '',
                                                      'label': 'Semua Status',
                                                    },
                                                    {
                                                      'value': 'Rencana',
                                                      'label': 'Rencana',
                                                    },
                                                    {
                                                      'value': 'Dibatalkan',
                                                      'label': 'Dibatalkan',
                                                    },
                                                    {
                                                      'value': 'Menunggu TTE',
                                                      'label': 'Menunggu TTE',
                                                    },
                                                    {
                                                      'value': 'TTE Ditolak',
                                                      'label': 'TTE Ditolak',
                                                    },
                                                    {
                                                      'value': 'Sudah TTE',
                                                      'label': 'Sudah TTE',
                                                    },
                                                    {
                                                      'value': 'Proses Validasi',
                                                      'label': 'Proses Validasi',
                                                    },
                                                    {
                                                      'value': 'Proses Pembayaran',
                                                      'label': 'Proses Pembayaran',
                                                    },
                                                    {
                                                      'value': 'Sudah Dibayar',
                                                      'label': 'Sudah Dibayar',
                                                    },
                                                    {
                                                      'value': 'Claim Ditolak',
                                                      'label': 'Claim Ditolak',
                                                    },
                                                  ],
                                                  decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.symmetric(
                                                          horizontal: 20, vertical: 15),
                                                      prefixIcon: Icon(Icons.filter_alt_outlined),
                                                      border: InputBorder.none,
                                                      hintText: 'Status',
                                                      hintStyle: TextStyle(
                                                        fontSize: 12
                                                      )
                                                  ),
                                              )
                                  )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 130),
              child: (perjadin.length==0&&page==1) ? setShimmerLoading() : listPerjadin(),
            )
        ],
      ),
    );
  }
}
