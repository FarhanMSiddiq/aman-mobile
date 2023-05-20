import 'package:aman_mobile/layout/navigation.dart';
import 'package:aman_mobile/layout/widget/snackbar.dart';
import 'package:aman_mobile/layout/widget/loading.dart';
import 'package:aman_mobile/model/user_data.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {

  bool hidePassword = true ;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


   Widget buildEmail() {
      return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.only(right: 25),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Color(0xfff3f3f3),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 60,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 25),
                    hintText: 'Masukkan Email',
                    hintStyle: TextStyle(
                      fontSize : 15
                    )
                  ),
            ),
          );
    }

    Widget buildPassword() {
      return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.only(right: 15),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Color(0xfff3f3f3),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 60,
            child: TextField(
              controller: passwordController,
              obscureText: hidePassword,
              style: TextStyle(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 25, top: 15),
                  hintText: 'Masukkan Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                       setState(() {
                          hidePassword = !hidePassword;
                        });
                    },
                    child: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                      color: hidePassword ? Colors.black54 : Colors.black87,
                    ),
                  ),
                  hintStyle: TextStyle(
                      fontSize : 15
                  )),
            ),
          );
  }

  Widget buildLoginBtn() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      child: ElevatedButton(
                onPressed: () {
                 loginAction();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF34AC69),
                  padding: EdgeInsets.all(15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
    );
  }

  void loginAction() async {
    showLoaderDialog(context);
    if(emailController.text==""){
      Navigator.pop(context);
      return snackBar("Email wajib diisi!",context);
    }else if(passwordController.text==""){
      Navigator.pop(context);
      return snackBar("Password wajib diisi!",context);
    }else{
      
      try {
          final dio = Dio();
          final login = await dio.post('https://staging.impstudio.id/aman_pendampingan_jp/api/v1/mobile/login', data: {
            'email' : emailController.text,
            'password' : passwordController.text
          });


          final loginResponse = await dio.post('https://staging.impstudio.id/aman_pendampingan_jp/api/v1/mobile/login', data: {
            'email' : emailController.text,
            'password' : passwordController.text
          });
          
          if(loginResponse.statusCode==200){

            var getProfile = await dio.post('https://staging.impstudio.id/aman_pendampingan_jp/api/v1/mobile/me',
                  options: Options(
                      headers: {
                        "Content-Type" : "application/json",
                        "Authorization" : "Bearer ${loginResponse.data['data']['access_token']}"
                      },
                    )
            );

            final SharedPreferences prefs = await SharedPreferences.getInstance();

            UserData userData = UserData(prefs);

            userData.id = loginResponse.data['data']['id'].toString();
            userData.name = loginResponse.data['data']['name'];
            userData.nik = getProfile.data['data']['nik'];
            userData.email = getProfile.data['data']['email'];
            userData.tanggalLahir = getProfile.data['data']['tanggal_lahir'];
            userData.jenisKelamin = getProfile.data['data']['jenis_kelamin'];
            userData.jabatan = getProfile.data['data']['jabatan'];
            userData.alamat = getProfile.data['data']['alamat'];
            userData.noTelp = getProfile.data['data']['no_telepon'];
            userData.level = loginResponse.data['data']['level'];
            userData.pathFoto = loginResponse.data['data']['profile_photo_path'] ?? "";

            userData.token = loginResponse.data['data']['access_token'];
            var now = DateTime.now();
            userData.tokenExpired = (new DateTime(now.year, now.month, now.day + 1))
                .millisecondsSinceEpoch;

            userData.save();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NavigationPage()));
          }
      } catch (e) {
        
        Navigator.pop(context);
        
        if(e is DioError){
          
          snackBar(e.response!.data['message']['error'], context);

        }else{
          snackBar(e.toString(), context);
        }

      }
      
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            margin: EdgeInsets.only(top: 80,bottom: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("AMAN",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F8245)
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text("Aplikasi Manajemen \nPerjalanan Dinas",
                      style: TextStyle(
                        fontSize: 14
                      ),
                    )
                  ],
                ),
                Image.asset('lib/images/logo.png',width: 100)
              ],
            )
          ),
          buildEmail(),
          buildPassword(),
          buildLoginBtn()
        ],
      )
    );
  }

}