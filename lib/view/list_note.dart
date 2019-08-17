import 'package:flutter/cupertino.dart';
import 'package:flutter_notes_app/model/note.dart';
import 'package:flutter/material.dart';

import 'note_page.dart';

class NoteList extends StatefulWidget {
  final List<Note> notedata;

  NoteList(this.notedata, {Key key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NoteListState();
  }
}

// Membuat widget GridView utk menampilkan data dari tabel note kedalam list
class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:

              // MediaQuery ini berfungsi utk mengatur posisi list yg akan dibuat
              //-dengan arah orientasi potrait/landscape
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 2
                  : 3),
      itemCount: widget.notedata.length == null ? 0 : widget.notedata.length,
      itemBuilder: (_, int i) {
        // GestureDetector berfungsi agar melakukan scrolling data pada widget Gridview
        return GestureDetector(
          // onTap bertugas ketika klik salah satu GridView akan membuka screen baru (NotePage)
          //-dengan mengirim data
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => NotePage(widget.notedata[i], false)));
          },

          // widget Card berfungsi utk menampung data dan ditampilkan di dalam GridView
          child: Card(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(14.0),
                  width: double.infinity,
                  child: Text(
                    widget.notedata[i].title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.notedata[i].note,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Created: ${widget.notedata[i].createDate}",
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Updated: ${widget.notedata[i].updateDate}",
                    style: TextStyle(fontSize: 12.0),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
