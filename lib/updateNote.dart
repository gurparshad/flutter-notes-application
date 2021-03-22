import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateNote extends StatefulWidget {
  final String noteTitle;
  final String noteDescription;
  final String documentId;
  UpdateNote({this.noteTitle, this.noteDescription, this.documentId});

  @override
  _UpdateNote createState() =>
      _UpdateNote(noteTitle, noteDescription, documentId);
}

class _UpdateNote extends State<UpdateNote> {
  String noteTitle;
  String noteDescription;
  String documentId;
  _UpdateNote(this.noteTitle, this.noteDescription, this.documentId);

  updateNote() async {
    await Firestore.instance
        .collection('notes')
        .document(documentId)
        .setData({'title': noteTitle, 'body': noteDescription});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          updateNote();
        },
        child: Text("Update"),
        backgroundColor: Color(0xffd84315),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.black,
          height: 50,
        ),
      ),
      backgroundColor: Color(0xff424242),
      appBar: AppBar(
        title: Text("Create Note"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    color: Color(0xa1ffffff)),
                child: TextFormField(
                  onChanged: (text) {
                    setState(() {
                      noteTitle = text;
                    });
                  },
                  initialValue: noteTitle,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                  color: Color(0xa1ffffff),
                ),
                child: TextFormField(
                  onChanged: (text) {
                    setState(() {
                      noteDescription = text;
                    });
                  },
                  maxLines: 9,
                  initialValue: noteDescription,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(),
                    hintText: 'Body',
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
