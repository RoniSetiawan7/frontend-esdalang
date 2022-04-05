class Latihan {
  String kodeLatihan, nmLatihan, nmGuru;
  int idKelas;

  Latihan({
    required this.kodeLatihan,
    required this.nmLatihan,
    required this.idKelas,
    required this.nmGuru,
  });

  factory Latihan.fromJson(Map<String, dynamic> json) => Latihan(
        kodeLatihan: json['kode_latihan'],
        nmLatihan: json['nm_latihan'],
        idKelas: json['id_kelas'],
        nmGuru: json['nm_guru'],
      );
}
