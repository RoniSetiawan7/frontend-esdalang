import 'package:esdalang_app/models/kurikulum.dart';
import 'package:esdalang_app/screens/kurikulum/tampil_kurikulum.dart';
import 'package:esdalang_app/services/kurikulum_services.dart';
import 'package:esdalang_app/widgets/appbar.dart';
import 'package:esdalang_app/widgets/background.dart';
import 'package:esdalang_app/widgets/loading.dart';
import 'package:esdalang_app/widgets/no_data_found.dart';
import 'package:flutter/material.dart';

class ListKurikulum extends StatefulWidget {
  final String idKelas;
  const ListKurikulum({Key? key, required this.idKelas}) : super(key: key);

  @override
  _ListKurikulumState createState() => _ListKurikulumState();
}

class _ListKurikulumState extends State<ListKurikulum> {
  Future<List<Kurikulum>>? _kurikulum;

  @override
  void initState() {
    super.initState();
    _kurikulum = KurikulumServices.getKurikulum(widget.idKelas);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          context: context,
          title: (widget.idKelas == '7')
              ? 'List Kurikulum - Kelas Tujuh'
              : (widget.idKelas == '8')
                  ? 'List Kurikulum - Kelas Delapan'
                  : 'List Kurikulum - Kelas Sembilan'),
      body: MyBackground(
        padding: const EdgeInsets.all(4),
        child: Center(
          child: FutureBuilder<List<Kurikulum>>(
            future: _kurikulum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Kurikulum>? kurikulum = snapshot.data!;
                return kurikulum.isEmpty
                    ? const MyNoDataFound()
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: kurikulum.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(kurikulum[index].nmMateri),
                              leading: CircleAvatar(
                                backgroundColor: Colors.lightBlue,
                                child: Text(
                                  kurikulum[index].nmMateri[0].toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              onTap: () => Navigator.pushNamed(
                                  context, '/tampilKurikulum',
                                  arguments: TampilKurikulum(
                                      kurikulum: kurikulum[index])),
                            ),
                          );
                        },
                      );
              } else if (snapshot.hasError) {
                return Text(
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16),
                );
              }
              return const MyLoading();
            },
          ),
        ),
      ),
    );
  }
}
