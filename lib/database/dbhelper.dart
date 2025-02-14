//DBHelper -> kelas tunggal yang membuat instance database
// bertanggung jawab utk inisialisasi pembuatan database.
import 'package:flutter_notes_app/model/note.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();

  DBHelper.internal();

  factory DBHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;

    _db = await setDB();

    return _db;
  }

  // Terdapat beberapa fungsi utk membuat database:
  //      -> setDB() yg akan dipanggil pada fungsi get db async.
  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path, "NoteDb");

    var dB = await openDatabase(path, version: 1, onCreate: _onCreate);

    return dB;
  }

  // _onCreate berfungsi utk membuat tabel baru dengan nama note
  // beberapa atribut seperti -> id, title, note, createDate, updateDate & sortDate beserta tipe datanya
  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE note(id INTEGER PRIMARY KEY, title TEXT, note TEXT, createDate TEXT, updateDate TEXT, sortDate TEXT)");

    print("DB Created");
  }

  // saveNote berfungsi utk menyimpan (insert) data pada tabel note
  Future<int> saveNote(Note note) async {
    var dbClient = await db;

    int res = await dbClient.insert("note", note.toMap());

    print("Data Inserted");

    return res;
  }

  // getNote berfungsi utk menampilkan (Read) data dari tabel note dalam bentuk ArrayList
  Future<List<Note>> getNote() async {
    var dbClient = await db;
    List<Map> list =
        await dbClient.rawQuery("SELECT * FROM note ORDER BY sortDate DESC");
    List<Note> notedata = new List();
    for (int i = 0; i < list.length; i++) {
      var note = Note(
        list[i]["title"],
        list[i]["note"],
        list[i]["createDate"],
        list[i]["updateDate"],
        list[i]["sortDate"],
      );
      note.setNoteId(list[i]['id']);
      notedata.add(note);
    }
    return notedata;
  }

  // updateNote berfungsi utk mengubah data pada tabel note dengan acuan id
  Future<bool> updateNote(Note note) async {
    var dbClient = await db;
    int res = await dbClient
        .update("note", note.toMap(), where: "id=?", whereArgs: <int>[note.id]);
    return res > 0 ? true : false;
  }

  // deleteNote berfungsi utk menghapus data dari tabel note dengan acuan id
  Future<int> deleteNote(Note note) async {
    var dbClient = await db;
    int res =
        await dbClient.rawDelete("DELETE FROM note WHERE id = ?", [note.id]);
    return res;
  }
}
