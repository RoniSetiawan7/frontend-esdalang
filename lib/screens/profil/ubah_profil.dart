import 'dart:convert';

import 'package:esdalang_app/models/siswa.dart';
import 'package:esdalang_app/services/http_services.dart';
import 'package:esdalang_app/widgets/appbar.dart';
import 'package:esdalang_app/widgets/background.dart';
import 'package:esdalang_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//! DATETIME -> JIKA BUTTON HIJAU BELUM DI KLIK, VALUE YG AKAN DISIMPAN ADALAH DATETIME.NOW()

class UbahProfil extends StatefulWidget {
  final Siswa siswa;
  const UbahProfil({Key? key, required this.siswa}) : super(key: key);

  @override
  _UbahProfilState createState() => _UbahProfilState();
}

class _UbahProfilState extends State<UbahProfil> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // ignore: prefer_typing_uninitialized_variables
  var nis, nmSiswa, jk, tempatLahir, agama, alamat, noTelp, idKelas, subKelas;

  DateTime? tglLahir;
  DateTime? hariIni = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.siswa.tglLahir ?? hariIni!,
        firstDate: DateTime(1990),
        lastDate: DateTime(2100));
    if (picked != null && picked != hariIni) {
      setState(() {
        hariIni = picked;
      });
    }
  }

  _showSuccessMsg(msg) {
    mySnackBar(
        context: context, message: '✔   ' + msg, color: Colors.green.shade400);
  }

  _showErrorMsg(msg) {
    mySnackBar(
        context: context, message: '✘   ' + msg, color: Colors.red.shade400);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _ubahProfil();
            }
          },
          icon: const Icon(Icons.save_outlined),
          label: _isLoading
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white)),
                    SizedBox(width: 10),
                    Text('Loading...',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white))
                  ],
                )
              : const Text(
                  'Simpan',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
        ),
        appBar: myAppBar(context: context, title: 'Edit Profil'),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue,
                  child: Text(
                    widget.siswa.nmSiswa[0].toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 36),
                  ),
                ),
                const SizedBox(height: 20),

                //* TEXTFIELD NOMOR INDUK SISWA
                _label(text: 'Nomor Induk Siswa :'),
                _textField(
                    hint: 'Nomor Induk Siswa',
                    initialValue: widget.siswa.nis.toString(),
                    validator: (nisValue) {
                      nis = nisValue;
                    },
                    readOnly: true),

                //* TEXTFIELD NAMA SISWA
                _label(text: 'Nama Siswa :', required: '*'),
                _textField(
                    hint: 'Nama Siswa',
                    initialValue: widget.siswa.nmSiswa,
                    validator: (nmSiswaValue) {
                      if (nmSiswaValue!.isEmpty) return '* Nama wajib diisi';
                      nmSiswa = nmSiswaValue;
                      return null;
                    },
                    readOnly: false),

                //* RADIO BUTTON JENIS KELAMIN
                _label(text: 'Jenis Kelamin :', required: '*'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: 'L',
                      groupValue: jk ?? widget.siswa.jk,
                      onChanged: (jkValue) {
                        setState(() {
                          jk = jkValue;
                        });
                      },
                    ),
                    const Text('Laki-laki'),
                    Radio(
                      value: 'P',
                      groupValue: jk ?? widget.siswa.jk,
                      onChanged: (jkValue) {
                        setState(() {
                          jk = jkValue;
                        });
                      },
                    ),
                    const Text('Perempuan'),
                  ],
                ),

                //* TEXTFIELD TEMPAT LAHIR
                _label(text: 'Tempat Lahir :'),
                _textField(
                    hint: 'Tempat Lahir',
                    initialValue: widget.siswa.tempatLahir,
                    validator: (tempatLahirValue) {
                      tempatLahir = tempatLahirValue;
                    },
                    readOnly: false),

                //* DATETIME TANGGAL LAHIR
                _label(text: 'Tanggal Lahir :', required: '*'),
                Container(
                  margin:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 15),
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                          widget.siswa.tglLahir == null
                              ? 'dd-mm-yyyy'
                              : DateFormat('dd-MM-yyyy').format(DateTime.parse(
                                  '${widget.siswa.tglLahir}'.split(' ')[0])),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: Text(
                          'Ubah : ' +
                              DateFormat('dd-MM-yyyy').format(
                                DateTime.parse(
                                    '${hariIni?.toLocal()}'.split(' ')[0]),
                              ),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                      ),
                    ],
                  ),
                ),

                //* DROPDOWN AGAMA
                _label(text: 'Agama :', required: '*'),
                Container(
                  margin:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 15),
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        value: agama ?? widget.siswa.agama,
                        onChanged: (agamaValue) {
                          setState(() {
                            agama = agamaValue;
                          });
                        },
                        hint: const Text('Pilih Agama'),
                        isExpanded: true,
                        items: <String>[
                          'Islam',
                          'Kristen',
                          'Katholik',
                          'Hindu',
                          'Buddha',
                          'Konghucu'
                        ].map<DropdownMenuItem<String>>((String listAgama) {
                          return DropdownMenuItem<String>(
                            value: listAgama,
                            child: Text(listAgama),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),

                //* TEXTFIELD ALAMAT
                _label(text: 'Alamat :'),
                _textField(
                    hint: 'Alamat',
                    initialValue: widget.siswa.alamat,
                    validator: (alamatValue) {
                      alamat = alamatValue;
                    },
                    readOnly: false),

                //* TEXTFIELD NOMOR TELP
                _label(text: 'No. Telp :'),
                _textField(
                    hint: 'No. Telp',
                    initialValue: widget.siswa.noTelp,
                    validator: (noTelpValue) {
                      noTelp = noTelpValue;
                    },
                    readOnly: false),

                //* DROPDOWN ID KELAS DAN SUB KELAS
                _label(text: 'Kelas & Sub Kelas:', required: '*'),
                Container(
                  margin:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width / 2.3,
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              value: idKelas ?? widget.siswa.idKelas,
                              onChanged: (idKelasValue) {
                                setState(() {
                                  idKelas = idKelasValue;
                                });
                              },
                              hint: const Text('Pilih Kelas'),
                              isExpanded: true,
                              items: <String>[
                                '7 Tujuh',
                                '8 Delapan',
                                '9 Sembilan'
                              ].map<DropdownMenuItem<String>>(
                                  (String listIdKelas) {
                                return DropdownMenuItem<String>(
                                  value: listIdKelas[0],
                                  child: Text(listIdKelas.split(' ')[1]),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 2.3,
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              value: subKelas ?? widget.siswa.subKelas,
                              onChanged: (subKelasValue) {
                                setState(() {
                                  subKelas = subKelasValue;
                                });
                              },
                              hint: const Text('Pilih Sub Kelas'),
                              isExpanded: true,
                              items: <String>['A', 'B', 'C', 'D', 'E', 'F']
                                  .map<DropdownMenuItem<String>>(
                                      (String listSubKelas) {
                                return DropdownMenuItem<String>(
                                  value: listSubKelas,
                                  child: Text(listSubKelas),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 70)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _ubahProfil() async {
    setState(() {
      _isLoading = true;
    });

    var id = nis.toString();
    var data = {
      'nis': nis,
      'nm_siswa': nmSiswa,
      'jk': jk ?? widget.siswa.jk,
      'tempat_lahir': tempatLahir,
      'tgl_lahir': hariIni?.toString().split(' ')[0] ??
          widget.siswa.tglLahir?.toString().split(' ')[0],
      'agama': agama ?? widget.siswa.agama,
      'alamat': alamat,
      'no_telp': noTelp,
      'id_kelas': idKelas ?? widget.siswa.idKelas,
      'sub_kelas': subKelas ?? widget.siswa.subKelas,
    };

    var res = await HttpServices.putData(data, '/update/', id);
    var body = json.decode(res.body);
    print(body);

    if (body['success']) {
      _showSuccessMsg(body['message']);
      Navigator.pushNamed(context, '/profile');
    } else {
      if (body['data']['nis'] != null) {
        _showErrorMsg(body['data']['nis'][0].toString());
      } else if (body['data']['nama'] != null) {
        _showErrorMsg(body['data']['nama'][0].toString());
      } else if (body['data']['jk'] != null) {
        _showErrorMsg(body['data']['jk'][0].toString());
      } else if (body['data']['agama'] != null) {
        _showErrorMsg(body['data']['agama'][0].toString());
      } else if (body['data']['id_kelas'] != null) {
        _showErrorMsg(body['data']['id_kelas'][0].toString());
      } else if (body['data']['sub_kelas'] != null) {
        _showErrorMsg(body['data']['sub_kelas'][0].toString());
      }
    }

    setState(() {
      _isLoading = false;
    });
  }
}

_textField(
    {required String hint, initialValue, validator, required bool readOnly}) {
  return Container(
    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 15),
    child: TextFormField(
      initialValue: initialValue,
      readOnly: readOnly,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        ),
        hintText: hint,
      ),
      validator: validator,
    ),
  );
}

_label({required String text, String? required}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(left: 16, bottom: 3),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      Container(
        margin: const EdgeInsets.only(left: 5, bottom: 3),
        child: Text(required ?? '',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.red)),
      ),
    ],
  );
}
