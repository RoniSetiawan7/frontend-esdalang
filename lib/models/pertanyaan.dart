class Pertanyaan {
  int id, bab;
  String idLatihan, soal, kodeMateri, nmMateri, materiPath, jawabanBenar;
  String? ketGambar, imagePath;
  List<String> jawabanSalah;

  Pertanyaan({
    required this.id,
    required this.idLatihan,
    required this.soal,
    this.ketGambar,
    this.imagePath,
    required this.kodeMateri,
    required this.nmMateri,
    required this.bab,
    required this.materiPath,
    required this.jawabanBenar,
    required this.jawabanSalah,
  });

  factory Pertanyaan.fromJson(Map<String, dynamic> json) => Pertanyaan(
        id: json['id'],
        idLatihan: json['id_latihan'],
        soal: json['soal'],
        ketGambar: json['ket_gambar'],
        imagePath: json['image_path'],
        kodeMateri: json['kode_materi'],
        nmMateri: json['nm_materi'],
        bab: json['bab'],
        materiPath: json['materi_path'],
        jawabanBenar: json['jawaban_benar'],
        jawabanSalah: List<String>.from(json['jawaban_salah'].map((x) => x)),
      );
}
