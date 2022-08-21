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
  String kodeMateri, nmMateri, nmKelas, nmGuru, bab, isiMateri;

  SubMateri({
    required this.kodeMateri,
    required this.nmMateri,
    required this.nmKelas,
    required this.nmGuru,
    required this.bab,
    required this.isiMateri,
  });

  factory SubMateri.fromJson(Map<String, dynamic> json) => SubMateri(
        kodeMateri: json['kode_materi'],
        nmMateri: json['nm_materi'],
        nmKelas: json['nm_kelas'],
        nmGuru: json['nm_guru'],
        bab: json['bab'],
        isiMateri: json['isi_materi'],
      );
}
