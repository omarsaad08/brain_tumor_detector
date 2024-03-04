import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dio/dio.dart';

class DatabaseService {
  final uid;
  DatabaseService({required this.uid});
  late final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection(uid);
  Future updateUserData(
      String patientName, String diagnoseDate, final response) async {
    // await usersCollection
    //     .doc(uid)
    //     .collection(patientName)
    //     .doc(patientName)
    //     .set({'Diagnose Date': diagnoseDate, 'result': response});
    await usersCollection
        .doc(patientName)
        .set({'Diagnose Date': diagnoseDate, 'result': response});
  }
}
