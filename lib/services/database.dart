import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dio/dio.dart';

class DatabaseService {
  late User? user;
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  bool? isDoctor;
  Map<String, dynamic>? userData;
  Map<String, dynamic>? doctorData;
  String? patientEmail;
  // late final CollectionReference usersCollection =
  //     FirebaseFirestore.instance.collection(uid!);
  DatabaseService({this.user}) {
    // get user information to know how to deal with his process of detecting and updating along the app
    db.collection('userData').doc(user!.email).get().then((value) async {
      userData = await value.data();

      isDoctor = await (userData!['type'] == 'patient' ? false : true);
      if (!isDoctor!) {
        // get his doctor's data
        db
            .collection('userData')
            .doc(userData!['doctorEmail'])
            .get()
            .then((value) {
          doctorData = value.data();
        });
      }
    });

    print("isDoctor?: ${isDoctor}");
  }

  Future<void> detectTumor(String patientName, String patientEmail,
      String diagnoseDate, File? image) async {
    try {
      print("user data: ${userData}");
      if (patientName != '') {
        final imagePath = 'images/${user!.uid}-${patientName}.jpg';
        await storage.ref().child(imagePath).putFile(image!);
        var formData = FormData.fromMap({'path': imagePath});
        Response response = await Dio().post(
            "https://tumordetector-fbcf91d4acbc.herokuapp.com/submit_path",
            data: formData);
        print(response.data['FireBasePath']);
        await db.collection(user!.uid).doc(patientName).set({
          'Diagnose Date': diagnoseDate,
          'result': response.data['prediction'],
          'segmentationPath': response.data['FireBasePath']
        });
        if (!isDoctor!) {
          await db.collection(doctorData!['uid']).doc(patientName).set({
            'Diagnose Date': diagnoseDate,
            'result': response.data['prediction'],
            'segmentationPath': response.data['FireBasePath']
          });
        } else if (isDoctor!) {
          await db.collection(doctorData!['uid']).doc(patientEmail).set({
            'Diagnose Date': diagnoseDate,
            'result': response.data['prediction'],
            'segmentationPath': response.data['FireBasePath']
          });
        }
      }
    } catch (e) {
      print("db error:${e}");
    }
  }

  Future<void> changeDoctorsPatients() async {
    try {
      if (isDoctor!) {
        db
            .collection('userData')
            .doc(user!.email)
            .update({"patientsNumber": userData!['patientsNumber'] + 1});
      } else {
        db
            .collection('userData')
            .doc(userData!['doctorEmail'])
            .update({"patientsNumber": doctorData!['patientsNumber'] + 1});
      }
    } catch (e) {
      print("change error: ${e}");
    }
  }

  Future<void> getPatientResult() async {}
  Future updateUserData(
      String patientName, String diagnoseDate, final response) async {
    // await usersCollection
    //     .doc(uid)
    //     .collection(patientName)
    //     .doc(patientName)
    //     .set({'Diagnose Date': diagnoseDate, 'result': response});
    // await usersCollection
    //     .doc(patientName)
    //     .set({'Diagnose Date': diagnoseDate, 'result': response});
  }
}
