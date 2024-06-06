import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('mahasiswa');

class FirebaseCrud {
  static Future<Response> addmahasiswa({
    required String name,
    required String hobi,
    required String nim,
    required String cita,
    required String kelas,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "nama": name,
      "hobi": hobi,
      "nim": nim,
      "kelas": kelas,
      "cita-cita": cita
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> updatemahasiswa({
    required String name,
    required String hobi,
    required String nim,
    required String cita,
    required String kelas,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "nama": name,
      "hobi": hobi,
      "nim": nim,
      "kelas": kelas,
      "cita-cita": cita
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Berhasil update data mahasiswa";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readmahasiswa() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> deletemahasiswa({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Berhasil Menghapus Data Mahasiswa";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
