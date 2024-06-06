import 'package:fl_cruddemo/page/listpage.dart';
import 'package:flutter/material.dart';

import '../models/employee.dart';
import '../services/firebase_crud.dart';

class EditPage extends StatefulWidget {
  final Mahasiswa? mahasiswa;
  EditPage({this.mahasiswa});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditPage();
  }
}

// ubah
class _EditPage extends State<EditPage> {
  final _mahasiswa_nama = TextEditingController();
  final _mahasiswa_nim = TextEditingController();
  final _mahasiswa_kelas = TextEditingController();
  final _mahasiswa_hobi = TextEditingController();
  final _mahasiswa_cita = TextEditingController();
  final _docid = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// ubah
  @override
  void initState() {
    // TODO: implement initState
    _docid.value = TextEditingValue(text: widget.mahasiswa!.uid.toString());
    _mahasiswa_nama.value =
        TextEditingValue(text: widget.mahasiswa!.nama.toString());
    _mahasiswa_nim.value =
        TextEditingValue(text: widget.mahasiswa!.nim.toString());
    _mahasiswa_kelas.value =
        TextEditingValue(text: widget.mahasiswa!.kelas.toString());
    _mahasiswa_hobi.value =
        TextEditingValue(text: widget.mahasiswa!.hobi.toString());
    _mahasiswa_cita.value =
        TextEditingValue(text: widget.mahasiswa!.cita.toString());
  }

// ubah
  @override
  Widget build(BuildContext context) {
    final DocIDField = TextField(
        controller: _docid,
        readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Nama",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final nameField = TextFormField(
        controller: _mahasiswa_nama,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Nama",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final nimField = TextFormField(
        controller: _mahasiswa_nim,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "nim",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final kelasField = TextFormField(
        controller: _mahasiswa_kelas,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "kelas",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final hobiField = TextFormField(
        controller: _mahasiswa_hobi,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "hobi",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final citaField = TextFormField(
        controller: _mahasiswa_cita,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "cita-cita",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final viewListbutton = TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ListPage(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
        },
        child: const Text('View List of mahasiswa'));

// ubah
    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var response = await FirebaseCrud.updatemahasiswa(
                name: _mahasiswa_nama.text,
                nim: _mahasiswa_nim.text,
                kelas: _mahasiswa_kelas.text,
                hobi: _mahasiswa_hobi.text,
                cita: _mahasiswa_cita.text,
                docId: _docid.text);
            if (response.code != 200) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            }
          }
        },
        child: Text(
          "Update",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('CRUD-Firebase'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DocIDField,
                  const SizedBox(height: 25.0),
                  nameField,
                  const SizedBox(height: 25.0),
                  nimField,
                  const SizedBox(height: 35.0),
                  kelasField,
                  const SizedBox(height: 35.0),
                  hobiField,
                  const SizedBox(height: 35.0),
                  citaField,
                  viewListbutton,
                  const SizedBox(height: 45.0),
                  SaveButon,
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
