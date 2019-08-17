import 'package:flutter/material.dart';
import 'package:flutter_notes_app/view/list_note.dart';
import 'package:flutter_notes_app/view/note_page.dart';

import 'database/dbhelper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SQFlite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var db = DBHelper();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => NotePage(
                    null,
                    true,
                  )));
        },
      ),
      appBar: AppBar(
        title: Center(
          child: Text('Tambah Catatan'),
        ),
      ),
      body: FutureBuilder(
        future: db.getNote(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          var data = snapshot.data;
          return snapshot.hasData
              ? NoteList(data)
              : Center(
                  child: Text('No Data'),
                );
        },
      ),
    );
  }
}
