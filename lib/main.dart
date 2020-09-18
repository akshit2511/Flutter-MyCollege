import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice/viewData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Flutter College",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String studentName, studentID, studyProgramID;
  double studentGPA;

  getStudentName(name) {
    this.studentName = name;
  }

  getStudentID(id) {
    this.studentID = id;
  }

  getStudentProgramID(programId) {
    this.studyProgramID = programId;
  }

  getStudentGPA(gpa) {
    this.studentGPA = double.parse(gpa);
  }

  createData() async {
    print("created");
    final databaseReference = Firestore.instance;
    await databaseReference
        .collection("MyStudents")
        .document(studentName)
        .setData({
      "studentName": studentName,
      "studentID": studentID,
      "studentGPA": studentGPA,
      "studentProgramID": studyProgramID
    });
  }

  readData() {
    print("read");
    final databaseReference = Firestore.instance;
    databaseReference.collection("MyStudents").getDocuments().then((snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  updateData() {
    try {
      print("updated");
      final databaseReference = Firestore.instance;
      databaseReference
          .collection("MyStudents")
          .document(studentName)
          .updateData({
        "studentName": studentName,
        "studentID": studentID,
        "studentGPA": studentGPA,
        "studentProgramID": studyProgramID
      });
    } catch (e) {
      print(e.toString());
    }
  }

  deleteData() {
    try {
      print("deleted");
      final databaseReference = Firestore.instance;
      databaseReference.collection("MyStudents").document(studentName).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("My Flutter College"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (String name) {
                getStudentName(name);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Student ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (String studentid) {
                getStudentID(studentid);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Study Program ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (String programID) {
                getStudentProgramID(programID);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "GPA",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (String gpa) {
                getStudentGPA(gpa);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: (() {
                  createData();
                }),
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Text("Create"),
                textColor: Colors.white,
              ),
              RaisedButton(
                onPressed: (() {
                  readData();
                }),
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Text("Read"),
                textColor: Colors.white,
              ),
              RaisedButton(
                onPressed: (() {
                  updateData();
                }),
                color: Colors.yellow[700],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Text("Update"),
                textColor: Colors.white,
              ),
              RaisedButton(
                onPressed: (() {
                  deleteData();
                }),
                color: Colors.orange[700],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Text("Delete"),
                textColor: Colors.white,
              ),
            ],
          ),
          Center(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: (() {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AllStudents();
                    }));
                  }),
                  color: Colors.red[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Text("All Students"),
                  textColor: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
