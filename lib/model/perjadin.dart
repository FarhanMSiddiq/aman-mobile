class Perjadin{
  int id;
  String idPerjadin;
  String jenisProgram;
  String status;
  String tglPendampingan;
  String namaKabupaten;
  String namaProvinsi;

  Perjadin(
    this.id ,
    this.idPerjadin,
    this.jenisProgram,
    this.status,
    this.tglPendampingan,
    this.namaKabupaten,
    this.namaProvinsi
  );
}


class RecapPerjadin{
  int recapSemua;
  int recapRencana;
  int recapTerlaksana;
  int recapReclaim;


  RecapPerjadin(
    this.recapSemua ,
    this.recapRencana,
    this.recapTerlaksana,
    this.recapReclaim
  );
}

class DetailPerjadin {
  int id;
  String namaLengkap;
  String tempatLahir;
  String tanggalLahir;
  String noTelepon;
  String npwp;
  String statusPegawai;
  String nik;
  String namaBank;
  String namaRekening;
  String noRekening;
  String jabatan;
  String wilayahKerjaProvinsi;
  String wilayahKerjaKabupaten;
  String kedudukanProvinsi;
  String kedudukanKabupaten;
  String kedudukanKecamatan;
  String tujuanProvinsi;
  String tujuanKabupaten;
  String tujuanKecamatan;
  String tglPendampingan;
  String jamMulai;
  String jamSelesai;
  String rekeningPath;
  String suratTugasPath;
  String spdPath;
  String tanggalLaporan;
  String tanggalTransfer;
  String jamTransfer;
  String pathTransfer;
  String status;

  DetailPerjadin(
      this.id,
      this.namaLengkap,
      this.tempatLahir,
      this.tanggalLahir,
      this.noTelepon,
      this.npwp,
      this.statusPegawai,
      this.nik,
      this.namaBank,
      this.namaRekening,
      this.noRekening,
      this.jabatan,
      this.wilayahKerjaProvinsi,
      this.wilayahKerjaKabupaten,
      this.kedudukanProvinsi,
      this.kedudukanKabupaten,
      this.kedudukanKecamatan,
      this.tujuanProvinsi,
      this.tujuanKabupaten,
      this.tujuanKecamatan,
      this.tglPendampingan,
      this.jamMulai,
      this.jamSelesai,
      this.rekeningPath,
      this.suratTugasPath,
      this.spdPath,
      this.tanggalLaporan,
      this.tanggalTransfer,
      this.jamTransfer,
      this.pathTransfer,
      this.status);
}


