import 'package:aman_mobile/layout/navigation.dart';
import 'package:aman_mobile/layout/widget/pdf_dialog.dart';
import 'package:aman_mobile/layout/widget/snackbar.dart';
import 'package:aman_mobile/layout/widget/loading.dart';
import 'package:aman_mobile/model/perjadin.dart';
import 'package:aman_mobile/model/user_data.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class DetailPerjadinPage extends StatefulWidget {
  const DetailPerjadinPage({super.key, required this.idPerjadin , required this.userData});

  final String idPerjadin;
  final UserData userData;

  @override
  State<DetailPerjadinPage> createState() => _DetailPerjadinPageState();
}

class _DetailPerjadinPageState extends State<DetailPerjadinPage> {

  DetailPerjadin? detailPerjadin;
  
  void initState(){
    getData();
  }

  void getData() async {
    try {
          final dio = Dio();

          final getDetail = await dio.get('https://staging.impstudio.id/aman_pendampingan_jp/api/v1/mobile/permohonan/${widget.idPerjadin}', 
            options: Options(
              headers: {
                "Content-Type" : "application/json",
                "Authorization" : "Bearer ${widget.userData.token}"
              },
            )
          );
          
          if(getDetail.statusCode==200){
            detailPerjadin = DetailPerjadin(
              getDetail.data['data']['id'],
              getDetail.data['data']['nama_lengkap'],
              getDetail.data['data']['tempat_lahir'],
              getDetail.data['data']['tanggal_lahir'],
              getDetail.data['data']['no_telepon'],
              getDetail.data['data']['npwp'],
              getDetail.data['data']['status_pegawai'],
              getDetail.data['data']['nik'],
              getDetail.data['data']['nama_bank'],
              getDetail.data['data']['nama_rekening'],
              getDetail.data['data']['no_rekening'],
              getDetail.data['data']['jabatan'],
              getDetail.data['data']['wilayah_kerja_provinsi'],
              getDetail.data['data']['wilayah_kerja_kabupaten'],
              getDetail.data['data']['kedudukan_provinsi'],
              getDetail.data['data']['kedudukan_kabupaten'],
              getDetail.data['data']['kedudukan_kecamatan'],
              getDetail.data['data']['tujuan_provinsi'],
              getDetail.data['data']['tujuan_kabupaten'],
              getDetail.data['data']['tujuan_kecamatan'],
              getDetail.data['data']['tgl_pendampingan'],
              getDetail.data['data']['jam_mulai'],
              getDetail.data['data']['jam_selesai'],
              getDetail.data['data']['rekening_path'],
              getDetail.data['data']['surat_tugas_path'],
              getDetail.data['data']['spd_path'],
              getDetail.data['data']['tanggal_laporan'],
              getDetail.data['data']['tanggal_transfer'],
              getDetail.data['data']['jam_transfer'],
              getDetail.data['data']['path_transfer'],
              getDetail.data['data']['status']
            );
          }

          setState(() {});

      } catch (e) {
        
        if(e is DioError){
          
          snackBar(e.toString(), context);

        }else{
          snackBar(e.toString(), context);
        }

      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text("Detail Perjadin",
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: (detailPerjadin!=null) ?
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              margin: EdgeInsets.only(top: 20,bottom: 20),
              child: Text("Data Pelaku Perjalanan Dinas",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF346D55)
                ),
              ),
            ),
            Table(
                  border: TableBorder.symmetric(
                      outside: const BorderSide(width: 1, color: Color.fromARGB(255, 166, 229, 187), style: BorderStyle.solid), 
                      inside: const BorderSide(width: 1, color: Color.fromARGB(255, 166, 229, 187), style: BorderStyle.solid),
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
                          child: Text("Nama",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(detailPerjadin!.namaLengkap ?? "")
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("Tempat Lahir",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(detailPerjadin!.tempatLahir ?? "")
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
                          child: Text(detailPerjadin!.tanggalLahir ?? "")
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("No. Telepon",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(detailPerjadin!.noTelepon ?? "")
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("NPWP",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(detailPerjadin!.npwp ?? "")
                        ),
                      ],
                    ),
                  ]),

                  Container(
                    margin: EdgeInsets.only(top: 20,bottom: 20),
                    child: Text("Bank",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF346D55)
                      ),
                    ),
                  ),
                  Table(
                        border: TableBorder.symmetric(
                            outside: const BorderSide(width: 1, color: Color.fromARGB(255, 166, 229, 187), style: BorderStyle.solid), 
                            inside: const BorderSide(width: 1, color: Color.fromARGB(255, 166, 229, 187), style: BorderStyle.solid),
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
                                child: Text("Nama Bank",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(detailPerjadin!.namaBank ?? "")
                              ),
                            ],
                          ),
                          TableRow(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text("Nama Rekening",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(detailPerjadin!.namaRekening ?? "")
                              ),
                            ],
                          ),
                          TableRow(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text("Nomor Rekening",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(detailPerjadin!.noRekening ?? "")
                              ),
                            ],
                          ),
                        ]),
                        Container(
                          margin: EdgeInsets.only(top: 20,bottom: 20),
                          child: Text("Wilayah Kerja",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF346D55)
                            ),
                          ),
                        ),
                        Table(
                        border: TableBorder.symmetric(
                            outside: const BorderSide(width: 1, color: Color.fromARGB(255, 166, 229, 187), style: BorderStyle.solid), 
                            inside: const BorderSide(width: 1, color: Color.fromARGB(255, 166, 229, 187), style: BorderStyle.solid),
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
                                child: Text("Jabatan",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(detailPerjadin!.jabatan ?? "")
                              ),
                            ],
                          ),
                          TableRow(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text("Provinsi",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(detailPerjadin!.wilayahKerjaProvinsi ?? "")
                              ),
                            ],
                          ),
                          TableRow(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text("Kabupaten/Kota",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(detailPerjadin!.wilayahKerjaKabupaten ?? "")
                              ),
                            ],
                          ),
                        ]),
                         Container(
                          margin: EdgeInsets.only(top: 20,bottom: 20),
                          child: Text("Lokasi Kedudukan",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF346D55)
                            ),
                          ),
                        ),
                        Table(
                        border: TableBorder.symmetric(
                            outside: const BorderSide(width: 1, color: Color.fromARGB(255, 166, 229, 187), style: BorderStyle.solid), 
                            inside: const BorderSide(width: 1, color: Color.fromARGB(255, 166, 229, 187), style: BorderStyle.solid),
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
                                child: Text("Provinsi",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(detailPerjadin!.kedudukanProvinsi ?? "")
                              ),
                            ],
                          ),
                          TableRow(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text("Kabupaten",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(detailPerjadin!.kedudukanKabupaten ?? "")
                              ),
                            ],
                          ),
                          TableRow(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text("Kecamatan",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(detailPerjadin!.kedudukanKecamatan ?? "")
                              ),
                            ],
                          ),
                        ]),
                        Container(
                          margin: EdgeInsets.only(top: 20,bottom: 20),
                          child: Text("Wilayah Tujuan",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF346D55)
                            ),
                          ),
                        ),
                        Table(
                        border: TableBorder.symmetric(
                            outside: const BorderSide(width: 1, color: Color.fromARGB(255, 166, 229, 187), style: BorderStyle.solid), 
                            inside: const BorderSide(width: 1, color: Color.fromARGB(255, 166, 229, 187), style: BorderStyle.solid),
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
                                child: Text("Provinsi",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(detailPerjadin!.tujuanProvinsi ?? "")
                              ),
                            ],
                          ),
                          TableRow(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text("Kabupaten",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(detailPerjadin!.tujuanKabupaten ?? "")
                              ),
                            ],
                          ),
                          TableRow(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text("Kecamatan",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(detailPerjadin!.tujuanKecamatan ?? "")
                              ),
                            ],
                          ),
                           TableRow(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text("Tanggal Pendampingan",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(detailPerjadin!.tglPendampingan ?? "")
                              ),
                            ],
                          ),
                          TableRow(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text("Jam Mulai",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(detailPerjadin!.jamMulai ?? "")
                              ),
                            ],
                          ),
                          TableRow(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text("Jam Selesai",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(detailPerjadin!.jamSelesai ?? "")
                              ),
                            ],
                          ),
                        ]),
                        Container(
                          margin: EdgeInsets.only(top: 20,bottom: 20),
                          child: Text("Scan Buku Rekening",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF346D55)
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 66, 65, 65)
                          ),
                          child: Image.network(detailPerjadin!.rekeningPath.replaceAll('aman-madrasah-staging', 'aman-madrasah') , width: MediaQuery.of(context).size.width, height: 150, fit: BoxFit.contain),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20,bottom: 20),
                          child: Text("Surat Tugas",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF346D55)
                            ),
                          ),
                        ),
                        (detailPerjadin!.suratTugasPath!="") ? 
                        InkWell(
                          onTap: (){
                              showPdfDialog(context, detailPerjadin!.suratTugasPath , "Surat Tugas");
                          },
                          child: Text("${detailPerjadin!.suratTugasPath} \n(Tekan untuk melihat surat)"),
                        ) : Text("Surat Tugas Belum Ada."),

                        Container(
                          margin: EdgeInsets.only(top: 20,bottom: 20),
                          child: Text("SPD",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF346D55)
                            ),
                          ),
                        ),
                        (detailPerjadin!.spdPath!="") ? 
                        InkWell(
                          onTap: (){
                              showPdfDialog(context, detailPerjadin!.spdPath , "SPD");
                          },
                          child: Text("${detailPerjadin!.suratTugasPath} \n(Tekan untuk melihat surat)"),
                        ) : Text("SPD Belum Ada."),

                        Container(
                          margin: EdgeInsets.only(top: 20,bottom: 20),
                          child: Text("Laporan Keuangan",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF346D55)
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text("Untuk melihat informasi keuangan silahkan lihat di situs web di https://aman.kemenag.go.id",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF346D55)
                            ),
                          ),
                        ),

                        (detailPerjadin!.status=="Sudah Dibayar") ?
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20,bottom: 20),
                              child: Text("Transfer",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF346D55)
                                ),
                              ),
                            ),

                            Table(
                              border: TableBorder.symmetric(
                                  outside: const BorderSide(width: 1, color: Color.fromARGB(255, 166, 229, 187), style: BorderStyle.solid), 
                                  inside: const BorderSide(width: 1, color: Color.fromARGB(255, 166, 229, 187), style: BorderStyle.solid),
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
                                      child: Text("Tanggal Pendampingan",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(detailPerjadin!.tglPendampingan ?? "")
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text("Tanggal Laporan",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(detailPerjadin!.tanggalLaporan ?? "")
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text("Tanggal Transfer",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(detailPerjadin!.tanggalTransfer ?? "")
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text("Jam Transfer",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(detailPerjadin!.jamTransfer ?? "")
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text("Status Perjadin (Pendampingan)",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(detailPerjadin!.status ?? "")
                                    ),
                                  ],
                                ),
                              ]),
                              Container(
                                height: 100,
                              )
                          ],
                        )

                        : Container()
                        
            ],
          ),
        ),
      ) : Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.7),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text("Sedang Mengambil Data..."),
              )
            ],
          ),
      )
    );
  }

}