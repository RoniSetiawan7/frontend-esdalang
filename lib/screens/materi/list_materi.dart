import 'package:esdalang_app/models/materi.dart';
import 'package:esdalang_app/screens/materi/list_sub_materi.dart';
import 'package:esdalang_app/services/materi_services.dart';
import 'package:esdalang_app/widgets/appbar.dart';
import 'package:esdalang_app/widgets/background.dart';
import 'package:esdalang_app/widgets/loading.dart';
import 'package:esdalang_app/widgets/no_data_found.dart';
import 'package:flutter/material.dart';

class ListMateri extends StatefulWidget {
  final String idKelas;
  const ListMateri({Key? key, required this.idKelas}) : super(key: key);

  @override
  _ListMateriState createState() => _ListMateriState();
}

class _ListMateriState extends State<ListMateri> {
  Future<List<Materi>>? _materi;

  @override
  void initState() {
    super.initState();
    _materi = MateriServices.getMateri(widget.idKelas);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          context: context,
          title: (widget.idKelas == '7')
              ? 'List Materi - Kelas Tujuh'
              : (widget.idKelas == '8')
                  ? 'List Materi - Kelas Delapan'
                  : 'List Materi - Kelas Sembilan'),
      body: MyBackground(
        padding: const EdgeInsets.all(4),
        child: Center(
          child: FutureBuilder<List<Materi>>(
            future: _materi,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Materi>? materi = snapshot.data!;
                return materi.isEmpty
                    ? const MyNoDataFound()
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: materi.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 16),
                              title: Text(materi[index].nmMateri),
                              leading: CircleAvatar(
                                backgroundColor: Colors.lightBlue,
                                child: Text(
                                  materi[index].nmMateri[0].toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  color: Colors.black12),
                              onTap: () =>
                                  Navigator.pushNamed(context, '/listSubMateri',
                                      arguments: ListSubMateri(
                                        materi: materi[index],
                                      )),
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
