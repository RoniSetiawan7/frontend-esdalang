class Kurikulum {
  String kodeKurikulum, nmMateri, nmKelas, fileKurikulum, kurikulumPath;
  String? keterangan;

  Kurikulum({
    required this.kodeKurikulum,
    required this.nmMateri,
    required this.nmKelas,
    required this.fileKurikulum,
    required this.kurikulumPath,
    this.keterangan,
  });

  factory Kurikulum.fromJson(Map<String, dynamic> json) => Kurikulum(
        kodeKurikulum: json['kode_kurikulum'],
        nmMateri: json['nm_materi'],
        nmKelas: json['nm_kelas'],
        fileKurikulum: json['file_kurikulum'],
        kurikulumPath: json['kurikulum_path'],
        keterangan: json['keterangan'],
      );
}
