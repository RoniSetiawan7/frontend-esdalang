import 'dart:convert';

import 'package:esdalang_app/functions/hide_keyboard.dart';
import 'package:esdalang_app/services/http_services.dart';
import 'package:esdalang_app/widgets/background.dart';
import 'package:esdalang_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/appbar.dart';
import 'widgets/button.dart';
import 'widgets/input_decoration.dart';

class HalamanRegistrasi extends StatefulWidget {
  const HalamanRegistrasi({Key? key}) : super(key: key);

  @override
  _HalamanRegistrasiState createState() => _HalamanRegistrasiState();
}

class _HalamanRegistrasiState extends State<HalamanRegistrasi> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _secureText = true;
  String? nis, password, passwordConfirmation;

  _showHide() {
    setState(() {
      _secureText = !_secureText;
    });
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
        extendBody: true,
        backgroundColor: Colors.transparent,
        appBar: myAuthAppBar(title: 'DAFTAR AKUN'),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.25,
                    width: size.width,
                    child: Image.asset('assets/images/mobile_learning.png'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: myInputDecoration(
                          icon: Icons.person_outline,
                          label: 'Nomor Induk Siswa'),
                      validator: (nisValue) {
                        if (nisValue!.isEmpty) return '* NIS wajib diisi';
                        nis = nisValue;
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 5),
                    child: TextFormField(
                      obscureText: _secureText,
                      maxLength: 15,
                      decoration: myInputDecoration(
                              icon: Icons.lock_outline, label: 'Password')
                          .copyWith(
                        suffixIcon: IconButton(
                          onPressed: _showHide,
                          icon: Icon(_secureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                        ),
                      ),
                      validator: (passwordValue) {
                        if (passwordValue!.isEmpty) {
                          return '* Password wajib diisi';
                        }
                        if (passwordValue.length < 8) {
                          return '* Password minimal 8 karakter';
                        }
                        password = passwordValue;
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 5, 16, 30),
                    child: TextFormField(
                      obscureText: _secureText,
                      maxLength: 15,
                      decoration: myInputDecoration(
                              icon: Icons.vpn_key_outlined,
                              label: 'Konfirmasi Password')
                          .copyWith(
                        suffixIcon: IconButton(
                          onPressed: _showHide,
                          icon: Icon(_secureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                        ),
                      ),
                      validator: (passwordConfirmationValue) {
                        if (passwordConfirmationValue!.isEmpty) {
                          return '* Konfirmasi Password wajib diisi';
                        }
                        if (passwordConfirmationValue != password) {
                          return '* Password dan Konfirmasi Password tidak cocok';
                        }
                        passwordConfirmation = passwordConfirmationValue;
                        return null;
                      },
                    ),
                  ),
                  MyButton(
                    text: 'DAFTAR',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        HideKeyboard.hideKeyboard(context);
                        _register();
                      }
                    },
                    loading: _isLoading,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 30, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Sudah punya akun? ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Flexible(
                          child: InkWell(
                            child: const Text('Login di sini',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold)),
                            onTap: () =>
                                Navigator.pushNamed(context, '/halamanLogin'),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'id_siswa': nis,
      'password': password,
      'password_confirmation': passwordConfirmation
    };

    var res = await HttpServices.postData(data, '/register');
    var body = json.decode(res.body);
    print(body);

    if (body['success']) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', json.encode(body['data']['token']));
      prefs.setString('nis', json.encode(body['data']['nis']));
      prefs.setString('nm_siswa', json.encode(body['data']['nm_siswa']));
      prefs.setString('id_kelas', json.encode(body['data']['id_kelas']));
      prefs.setString('sub_kelas', json.encode(body['data']['sub_kelas']));
      prefs.setString('foto_path', json.encode(body['data']['foto_path']));

      _showSuccessMsg(body['message']);
      Navigator.pushNamedAndRemoveUntil(
          context, '/halamanUtama', (Route<dynamic> route) => false);
    } else {
      if (body['data']['id_siswa'] != null) {
        _showErrorMsg(body['data']['id_siswa'][0].toString());
      } else if (body['data']['error'] != null) {
        _showErrorMsg(body['data']['error'].toString());
      }
    }

    setState(() {
      _isLoading = false;
    });
  }
}
