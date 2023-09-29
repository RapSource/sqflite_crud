import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'form_input.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DatabaseCrud? database;
  List listData = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      database = DatabaseCrud();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Tabel Data')),
        body: FutureBuilder(
            future: database?.getUser(),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FormInput()));
                          },
                          child: const Text('Tambah Data +',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: IntrinsicWidth(
                          child: Stack(children: [
                            Container(
                              color: Colors.lightBlue,
                              height: 55,
                            ),
                            DataTable(
                              border: TableBorder.all(width: 1.0),
                              columns: const [
                                DataColumn(
                                    label: Text(
                                  'No',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Nama',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                  label: Text(
                                    'Email',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                    label: Text(
                                  'No Handphone',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Tanggal Lahir',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Jenis Kelamin',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Aksi',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                              ],
                              rows: snapshot.data
                                      ?.map(
                                        (data) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(data.idUser.toString()),
                                            ),
                                            DataCell(
                                              Text(data.name),
                                            ),
                                            DataCell(
                                              Text(data.email),
                                            ),
                                            DataCell(
                                              Text(data.noHp),
                                            ),
                                            DataCell(
                                              Text(
                                                  data.tanggalLahir.toString()),
                                            ),
                                            DataCell(
                                              Text(data.jenisKelamin),
                                            ),
                                            DataCell(
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon:
                                                        const Icon(Icons.edit),
                                                    onPressed: () {
                                                      database?.editUser(data);
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        database?.removeUser(
                                                            data.idUser!);
                                                      });
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList() ??
                                  [
                                    DataRow(
                                      cells: [
                                        const DataCell(
                                          Text(''),
                                        ),
                                        const DataCell(
                                          Text(''),
                                        ),
                                        const DataCell(
                                          Text(''),
                                        ),
                                        const DataCell(
                                          Text(''),
                                        ),
                                        const DataCell(
                                          Text(''),
                                        ),
                                        const DataCell(
                                          Text(''),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit),
                                                onPressed: () {},
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {},
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
