class Nilai {
  int id, idSiswa;
  String idLatihan, jawaban;
  dynamic nilai;

  Nilai({
    required this.id,
    required this.idLatihan,
    required this.idSiswa,
    required this.jawaban,
    required this.nilai,
  });

  factory Nilai.fromJson(Map<String, dynamic> json) => Nilai(
        id: json['id'],
        idLatihan: json['id_latihan'],
        idSiswa: json['id_siswa'],
        jawaban: json['jawaban'],
        nilai: json['nilai'],
      );
}
