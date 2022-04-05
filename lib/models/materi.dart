class Materi {
  String nmMateri;

  Materi({
    required this.nmMateri,
  });

  factory Materi.fromJson(Map<String, dynamic> json) => Materi(
        nmMateri: json['nm_materi'],
      );
}

class SubMateri {
  String kodeMateri, nmMateri, nmKelas, nmGuru, fileMateri, materiPath;
  int bab;

  SubMateri({
    required this.kodeMateri,
    required this.nmMateri,
    required this.nmKelas,
    required this.nmGuru,
    required this.bab,
    required this.fileMateri,
    required this.materiPath,
  });

  factory SubMateri.fromJson(Map<String, dynamic> json) => SubMateri(
        kodeMateri: json['kode_materi'],
        nmMateri: json['nm_materi'],
        nmKelas: json['nm_kelas'],
        nmGuru: json['nm_guru'],
        bab: json['bab'],
        fileMateri: json['file_materi'],
        materiPath: json['materi_path'],
      );
}
