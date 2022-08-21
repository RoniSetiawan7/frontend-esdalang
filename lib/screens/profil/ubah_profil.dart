import 'dart:convert';

import 'package:esdalang_app/constant/url.dart';
import 'package:esdalang_app/models/siswa.dart';
import 'package:esdalang_app/services/http_services.dart';
import 'package:esdalang_app/widgets/appbar.dart';
import 'package:esdalang_app/widgets/background.dart';
import 'package:esdalang_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'widgets/label.dart';
import 'widgets/textfield.dart';

class UbahProfil extends StatefulWidget {
  final Siswa siswa;
  const UbahProfil({Key? key, required this.siswa}) : super(key: key);

  @override
  _UbahProfilState createState() => _UbahProfilState();
}

class _UbahProfilState extends State<UbahProfil> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isClosed = false;

  void _closed() {
    setState(() {
      _isClosed = true;
    });
  }

  // ignore: prefer_typing_uninitialized_variables
  var nis, nmSiswa, jk, tempatLahir, agama, alamat, noTelp, idKelas, subKelas;

  DateTime tglLahir = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.siswa.tglLahir ?? tglLahir,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    if (picked != null && picked != tglLahir) {
      setState(() {
        tglLahir = picked;
      });
    }
    if (widget.siswa.tglLahir != null) {
      setState(() {
        widget.siswa.tglLahir = picked;
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
                widget.siswa.fotoPath == null
                    ? CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.blue,
                        child: Text(
                          widget.siswa.nmSiswa[0].toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 36),
                        ),
                      )
                    : CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            NetworkImage(baseUrl + widget.siswa.fotoPath!),
                        backgroundColor: Colors.transparent,
                      ),
                const SizedBox(height: 20),

                !_isClosed
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                child: const Icon(Icons.close),
                                onTap: () => _closed(),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: const [
                                  Text(
                                    'Informasi !',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Jika terdapat kesalahan data yang tidak dapat dirubah oleh siswa, silahkan hubungi guru untuk melakukan perubahan data.',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      )
                    : Container(),

                //* Textfield Nomor Induk Siswa
                const MyLabel(text: 'Nomor Induk Siswa :'),
                MyTextField(
                    hint: 'Nomor Induk Siswa',
                    initialValue: widget.siswa.nis.toString(),
                    validator: (nisValue) {
                      nis = nisValue;
                    },
                    readOnly: true),

                //* Textfield Nama Siswa
                const MyLabel(text: 'Nama Siswa :', required: '*'),
                MyTextField(
                    hint: 'Nama Siswa',
                    initialValue: widget.siswa.nmSiswa,
                    validator: (nmSiswaValue) {
                      nmSiswa = nmSiswaValue;
                    },
                    readOnly: true),

                //* Radio Button Jenis Kelamin
                const MyLabel(text: 'Jenis Kelamin :', required: '*'),
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

                //* Textfield Tempat Lahir
                const MyLabel(text: 'Tempat Lahir :'),
                MyTextField(
                    hint: 'Tempat Lahir',
                    initialValue: widget.siswa.tempatLahir,
                    validator: (tempatLahirValue) {
                      tempatLahir = tempatLahirValue;
                    },
                    readOnly: false),

                //* DateTime Tanggal Lahir
                const MyLabel(text: 'Tanggal Lahir :', required: '*'),
                Container(
                  margin:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 15),
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: IgnorePointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black),
                          hintText: DateFormat('dd MMMM yyyy')
                              .format(widget.siswa.tglLahir ?? tglLahir),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //* Dropdown Agama
                const MyLabel(text: 'Agama :', required: '*'),
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

                //* Textfield Alamat
                const MyLabel(text: 'Alamat :'),
                MyTextField(
                    hint: 'Alamat',
                    initialValue: widget.siswa.alamat,
                    validator: (alamatValue) {
                      alamat = alamatValue;
                    },
                    readOnly: true),

                //* Textfield Nomor Telepon
                const MyLabel(text: 'No. Telp :'),
                MyTextField(
                    hint: 'No. Telp',
                    initialValue: widget.siswa.noTelp,
                    validator: (noTelpValue) {
                      noTelp = noTelpValue;
                    },
                    readOnly: false),

                //* Dropdown Id Kelas dan Sub Kelas
                const MyLabel(text: 'Kelas & Sub Kelas:', required: '*'),
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
                              // onChanged: (idKelasValue) {
                              //   setState(() {
                              //     idKelas = idKelasValue;
                              //   });
                              // },
                              onChanged: null,
                              hint: const Text('Pilih Kelas'),
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                  child: Text('Tujuh'),
                                  value: 7,
                                ),
                                DropdownMenuItem(
                                  child: Text('Delapan'),
                                  value: 8,
                                ),
                                DropdownMenuItem(
                                  child: Text('Sembilan'),
                                  value: 9,
                                ),
                              ],
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
                              // onChanged: (subKelasValue) {
                              //   setState(() {
                              //     subKelas = subKelasValue;
                              //   });
                              // },
                              onChanged: null,
                              hint: const Text('Pilih Sub Kelas'),
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                  child: Text('A'),
                                  value: 'A',
                                ),
                                DropdownMenuItem(
                                  child: Text('B'),
                                  value: 'B',
                                ),
                                DropdownMenuItem(
                                  child: Text('C'),
                                  value: 'C',
                                ),
                                DropdownMenuItem(
                                  child: Text('D'),
                                  value: 'D',
                                ),
                                DropdownMenuItem(
                                  child: Text('E'),
                                  value: 'E',
                                ),
                              ],
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
      'tgl_lahir': widget.siswa.tglLahir?.toString().split(' ')[0] ??
          tglLahir.toString().split(' ')[0],
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
      Navigator.pop(context);
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
