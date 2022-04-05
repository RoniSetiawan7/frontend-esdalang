import 'package:esdalang_app/models/materi.dart';
import 'package:esdalang_app/screens/materi/tampil_materi.dart';
import 'package:esdalang_app/services/materi_services.dart';
import 'package:esdalang_app/widgets/appbar.dart';
import 'package:esdalang_app/widgets/background.dart';
import 'package:esdalang_app/widgets/loading.dart';
import 'package:esdalang_app/widgets/no_data_found.dart';
import 'package:flutter/material.dart';

class ListSubMateri extends StatefulWidget {
  final Materi materi;
  const ListSubMateri({Key? key, required this.materi}) : super(key: key);

  @override
  _ListSubMateriState createState() => _ListSubMateriState();
}

class _ListSubMateriState extends State<ListSubMateri> {
  Future<List<SubMateri>>? _subMateri;

  @override
  void initState() {
    super.initState();
    _subMateri = MateriServices.getSubMateri(widget.materi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context, title: widget.materi.nmMateri),
      body: MyBackground(
        padding: const EdgeInsets.all(4),
        child: Center(
          child: FutureBuilder<List<SubMateri>>(
            future: _subMateri,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<SubMateri>? subMateri = snapshot.data!;
                return subMateri.isEmpty
                    ? const MyNoDataFound()
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: subMateri.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(subMateri[index].nmMateri),
                              subtitle: Text(
                                  'Bab : ' + subMateri[index].bab.toString()),
                              leading: CircleAvatar(
                                backgroundColor: Colors.lightBlue,
                                child: Text(
                                  subMateri[index].nmMateri[0].toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              onTap: () =>
                                  Navigator.pushNamed(context, '/tampilMateri',
                                      arguments: TampilMateri(
                                        subMateri: subMateri[index],
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
