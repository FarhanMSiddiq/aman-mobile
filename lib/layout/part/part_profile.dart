import 'package:aman_mobile/layout/login.dart';
import 'package:aman_mobile/model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';



Widget PartProfile(BuildContext context, UserData userData){

    void showConfirmLogout(){
          showDialog(context: context,
                    builder: (BuildContext context){
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20
                                , bottom: 20
                            ),
                            margin: EdgeInsets.only(top: 45), 
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(color: Colors.black,offset: Offset(0,0.2),
                                blurRadius: 3
                                ),
                              ]
                            ),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("Logout",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))
                                  ),
                                  Container(
                                    margin:  EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                    child: Text("Apakah anda yakin ingin logout akun ini?", style: TextStyle(fontSize: 14))
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin : EdgeInsets.only(top:10),
                                    child: Wrap(
                                    spacing : 5,
                                    children:[
                                      OutlinedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                                        ),
                                        onPressed: (){
                                            userData.clear();
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage(title: 'Login')));
                                        },
                                        child: Text("Ya ",style: TextStyle(fontSize: 12,color:Colors.green))),
                                      OutlinedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                                        ),
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                      child:  Text("Tidak",style: TextStyle(fontSize: 12,color:Colors.red))),
                                      ]
                                    )
                                  )
                                ],
                              ),
                            )
                        ],
                      )
                      );
              }
          );
        }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Profile",
                style: TextStyle(
                  fontSize: 17
                ),
              ),
              IconButton(icon: Icon(Icons.logout), onPressed: () {
                  showConfirmLogout();
              }),
            ],
          ),
          ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: (userData!.pathFoto!="") ? Image.network(userData!.pathFoto.replaceAll('aman-madrasah-staging', 'aman-madrasah') , width: 100 , height: 100 , fit: BoxFit.cover,) : 
                    Image.asset('lib/images/ic_user.png' , height: 100 , width: 100),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(userData.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Text(userData.noTelp),
          Container(
            margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                borderRadius:
                new BorderRadius.circular(16.0),
                color: Colors.white,
              ),
              child: Column(
                children: [
                Table(
                  border: TableBorder.symmetric(
                      outside: BorderSide.none, 
                      inside: BorderSide.none,
                  ),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("NIK",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(userData.nik)
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("Email",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(userData.email)
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("Tanggal Lahir",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(userData.tanggalLahir)
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("Jenis Kelamin",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(userData.jenisKelamin)
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("Jabatan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(userData.jabatan)
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("Alamat",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(userData.alamat)
                        ),
                      ],
                    )
                  ])
                ],
              )
          )
        ]
      ),
    ),
  );
}