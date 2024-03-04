// import 'dart:js_interop';

import 'package:brain_tumor_detector/screens/detect_tumor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:brain_tumor_detector/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List patients = [];
  final db = FirebaseFirestore.instance;
  Future fetchPatients() async {
    final docRef = db.collection(FirebaseAuth.instance.currentUser!.uid);
    await docRef.get().then(
      (querySnapshot) async {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print("getting segmentation");
          var url =
              await getImageUrl(docSnapshot.id, docSnapshot.data()['result']);
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          patients.add([
            docSnapshot.id,
            docSnapshot.data()['Diagnose Date'],
            docSnapshot.data()['result'],
            url
          ]);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  late String imageUrl;
  final storage = FirebaseStorage.instance;
  @override
  void initState() {
    super.initState();
    imageUrl = '';
  }

  Future<String> getImageUrl(String name, String result) async {
    final ref = storage.ref().child(
        "segmentation/${FirebaseAuth.instance.currentUser!.uid}-${name}-${result}.jpg");
    final url = await ref.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 43, 55, 93),
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF344372),
      //   title: Text("Tumora", style: TextStyle(color: Colors.white)),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      // ),
      body: FutureBuilder(
        future: fetchPatients(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFF344372),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF344372)),
                    // color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Patient Name: \n${patients[index][0]}",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "Diagnose Date: \n${patients[index][1]}",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.right,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Result:  ${patients[index][2]}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          Image(
                              image: NetworkImage(patients[index][3]),
                              fit: BoxFit.cover)
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
/*

*/