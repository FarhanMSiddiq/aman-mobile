import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  late String id = "";
  late String name = "";
  late String nik = "";
  late String email = "";
  late String tanggalLahir = "";
  late String jenisKelamin = "";
  late String jabatan = "";
  late String alamat = "";
  late String noTelp = "";
  late String level = "";
  late String pathFoto = "";
  late String token = "";
  late int tokenExpired = 0;

  SharedPreferences? sharedPreferences;

  UserData(this.sharedPreferences) {
    this.loadData();
  }

  void loadData() {
    this.id =
        this.sharedPreferences!.getString("id") ?? "";
    this.name =
        this.sharedPreferences!.getString("name") ?? "";
    this.nik =
        this.sharedPreferences!.getString("nik") ?? "";
    this.email =
        this.sharedPreferences!.getString("email") ?? "";
    this.tanggalLahir =
        this.sharedPreferences!.getString("tanggal_lahir") ?? "";
    this.jenisKelamin =
        this.sharedPreferences!.getString("jenis_kelamin") ?? "";
    this.jabatan =
        this.sharedPreferences!.getString("jabatan") ?? "";
    this.alamat =
        this.sharedPreferences!.getString("alamat") ?? "";
    this.noTelp =
        this.sharedPreferences!.getString("no_telepon") ?? "";
    this.level =
        this.sharedPreferences!.getString("level") ?? "";    
    this.pathFoto =
        this.sharedPreferences!.getString("path_foto") ?? "";    
    this.token =
        this.sharedPreferences!.getString("token") ?? "";
    this.tokenExpired =
        this.sharedPreferences!.getInt("token_expired") ??
            0;
  }

  save() {
    this.sharedPreferences!.setString("id", this.id);
    this.sharedPreferences!.setString("name", this.name);
    this.sharedPreferences!.setString("nik", this.nik);
    this.sharedPreferences!.setString("email", this.email);
    this.sharedPreferences!.setString("tanggal_lahir", this.tanggalLahir);
    this.sharedPreferences!.setString("jenis_kelamin", this.jenisKelamin);
    this.sharedPreferences!.setString("jabatan", this.jabatan);
    this.sharedPreferences!.setString("alamat", this.alamat);
    this.sharedPreferences!.setString("no_telepon", this.noTelp);
    this.sharedPreferences!.setString("level", this.level);
    this.sharedPreferences!.setString("path_foto", this.pathFoto);
    this.sharedPreferences!.setString("token", this.token);
    this.sharedPreferences!.setInt("token_expired", this.tokenExpired);
  }

  void clear() {
    this.clearProperties();
    this.sharedPreferences!.clear();
  }

  void clearProperties() {
    this.id = "";
    this.name = "";
    this.nik = "";
    this.email = "";
    this.tanggalLahir = "";
    this.jenisKelamin = "";
    this.jabatan = "";
    this.alamat = "";
    this.noTelp = "";
    this.level = "";
    this.pathFoto = "";
    this.token = "";
    this.tokenExpired = 0;
  }
}
