import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllStudents extends StatefulWidget {
  @override
  _AllStudentsState createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("All Students")),
        actions: <Widget>[
          Icon(
            Icons.search,
            color: Colors.blue,
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Student ID",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Study Program ID",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Student GPA",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            StreamBuilder(
              stream: Firestore.instance.collection("MyStudents").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data.documents[index];
                        return Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(documentSnapshot["studentName"])),
                            Expanded(
                                child: Text(documentSnapshot["studentID"])),
                            Expanded(
                                child:
                                    Text(documentSnapshot["studentProgramID"])),
                            Expanded(
                                child: Text(
                                    documentSnapshot["studentGPA"].toString()))
                          ],
                        );
                      });
                } else {
                  return Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
