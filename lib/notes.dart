import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'create.dart';
import 'updateNote.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff424242),
        appBar: AppBar(
          title: Text("Notes App"),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Create()),
            );
          },
          child: Icon(Icons.add),
          elevation: 0,
          backgroundColor: Color(0xffd84315),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: Colors.black,
            height: 50,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('notes').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 0,
                        color: Color(0x11ffffff),
                        child: new ListTile(
                          title: new Text(
                            document['title'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: new Text(document['body'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                          trailing: Wrap(
                            children: <Widget>[
                              new IconButton(
                                icon: new Icon(Icons.edit,
                                    color: Colors.blueGrey),
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateNote(
                                            documentId: document.documentID,
                                            noteTitle: document['title'],
                                            noteDescription: document['body'])),
                                  );
                                },
                              ),
                              new IconButton(
                                icon: new Icon(Icons.delete, color: Colors.red),
                                highlightColor: Colors.pink,
                                onPressed: () async {
                                  await Firestore.instance
                                      .collection('notes')
                                      .document(document.documentID)
                                      .delete();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
            }
          },
        ));
  }
}
