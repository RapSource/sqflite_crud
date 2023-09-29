import 'package:crud/user_model.dart';
import 'package:flutter/material.dart';

import 'db_helper.dart';

class FormInput extends StatefulWidget {
  const FormInput({super.key});

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  var _database = DatabaseCrud();

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _noHp = TextEditingController();
  final TextEditingController _tglLahir = TextEditingController();
  String? _jenisKelamin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Input')),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              border: Border.all(width: 0.5),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(2, 3), // changes position of shadow
                ),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(15),
                child: const Text('Input Data',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 26,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(10),
                height: 250,
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _firstName,
                            autofocus: false,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(left: 20),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.indigoAccent, width: 5.0),
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'Nama Depan'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _lastName,
                            autofocus: false,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(left: 20),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.indigoAccent, width: 5.0),
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'Nama Belakang'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _email,
                      autofocus: false,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(left: 20),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.indigoAccent, width: 5.0),
                              borderRadius: BorderRadius.circular(10)),
                          hintText: 'Email'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _noHp,
                      autofocus: false,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(left: 20),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.indigoAccent, width: 5.0),
                              borderRadius: BorderRadius.circular(10)),
                          hintText: 'Nomor Handphone'),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _tglLahir,
                            autofocus: false,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(left: 20),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.indigoAccent, width: 5.0),
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'Tanggal Lahir'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          height: 48,
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: DropdownButton(
                              underline: SizedBox(),
                              padding: const EdgeInsetsDirectional.all(5),
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(10),
                              items: const <DropdownMenuItem<String>>[
                                DropdownMenuItem<String>(
                                  value: 'Male',
                                  child: Text('Laki-laki'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Female',
                                  child: Text('Perempuan'),
                                ),
                              ],
                              value: _jenisKelamin,
                              hint: const Text('Jenis Kelamin'),
                              onChanged: (String? value) {
                                setState(() {
                                  _jenisKelamin = value;
                                });
                              }),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: Center(
                      child: ElevatedButton(
                          onPressed: () {
                            String namaLengkap =
                                _firstName.text + _lastName.text;
                            String email = _email.text;
                            String noHp = _noHp.text;
                            String tanggalLahir = _tglLahir.text;
                            String jenisKelamin = _jenisKelamin.toString();

                            setState(() {
                              _database.insertUser(User(
                                  name: namaLengkap,
                                  email: email,
                                  noHp: noHp,
                                  tanggalLahir: tanggalLahir,
                                  jenisKelamin: jenisKelamin));
                            });

                            _firstName.clear();
                            _lastName.clear();
                            _email.clear();
                            _noHp.clear();
                            _tglLahir.clear();
                          },
                          child: const Text(
                            'Simpan',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: Center(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Kembali',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
