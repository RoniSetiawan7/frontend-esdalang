class Siswa {
  int nis;
  String nmSiswa;
  String? jk, tempatLahir, agama, alamat, noTelp, idKelas, subKelas;
  DateTime? tglLahir;

  Siswa({
    required this.nis,
    required this.nmSiswa,
    this.jk,
    this.tempatLahir,
    this.tglLahir,
    this.agama,
    this.alamat,
    this.noTelp,
    this.idKelas,
    this.subKelas,
  });

  factory Siswa.fromJson(Map<String, dynamic> json) => Siswa(
        nis: json['nis'],
        nmSiswa: json['nm_siswa'],
        jk: json['jk'],
        tempatLahir: json['tempat_lahir'],
        tglLahir: DateTime.tryParse(json['tgl_lahir'].toString()),
        agama: json['agama'],
        alamat: json['alamat'],
        noTelp: json['no_telp'],
        idKelas: json['id_kelas'],
        subKelas: json['sub_kelas'],
      );

  Map<String, dynamic> toJson() => {
        'nis': nis,
        'nm_siswa': nmSiswa,
        'jk': jk,
        'tempat_lahir': tempatLahir,
        'tgl_lahir': tglLahir,
        'agama': agama,
        'alamat': alamat,
        'no_telp': noTelp,
        'id_kelas': idKelas,
        'sub_kelas': subKelas,
      };
}
