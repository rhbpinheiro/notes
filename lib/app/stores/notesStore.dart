import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:notes/app/controller/noteController.dart';
import 'package:notes/app/models/noteModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
part 'notesStore.g.dart';

class NotesStore = _NotesStoreBase with _$NotesStore;

abstract class _NotesStoreBase with Store {
  @observable
  bool loagindNote = false;

  @action
  void setLoading() {
    loagindNote = !loagindNote;
  }

  @observable
  String noteTitle = '';

  @action
  void setNotes(String value) => noteTitle = value;

  @computed
  bool get isFormValid => noteTitle.isNotEmpty;

  @observable
  bool editIsvalid = false;

  @action
  void seteditIsvalid() {
    editIsvalid = !editIsvalid;
  }

  @observable
  ObservableList<NoteModel> noteList = ObservableList<NoteModel>();

  @action
  Future<void> addNotes() async {
    final newNote = NoteModel(text: noteTitle);

    final addedNote = await NoteController().addNote(newNote.text!);
    if (addedNote != null) {
      noteList.insert(0, addedNote);
      saveNotesList();
    } else {
      print("Erro ao adicionar a nota à API.");
    }
  }

  @action
  Future<void> removeNotes(String noteId) async {
    await NoteController().delete(noteId);
    apiNotesList();
    saveNotesList();
  }

  @action
  Future<void> editNotes(String noteId, String newText) async {
    await NoteController().update(noteId, newText);
    apiNotesList();
  }

  @action
  Future<List<dynamic>> apiNotesList() async {
    List<NoteModel> fetchedNotes = await NoteController().getAllNotes();

    noteList = ObservableList.of(fetchedNotes);

    return fetchedNotes;
  }

  @action
  Future<void> saveNotesList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> notesListJson =
        noteList.map((note) => jsonEncode(note.toJson())).toList();

    await prefs.setStringList('notesList', notesListJson);
  }

  @action
  Future<List<dynamic>> sharedNotesList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> notesListJson = prefs.getStringList('notesList') ?? [];

    List<NoteModel> loadedNotes = notesListJson
        .map((noteJson) => NoteModel.fromJson(jsonDecode(noteJson)))
        .toList();

    noteList = ObservableList.of(loadedNotes);

    return loadedNotes;
  }

  @action
  Future<List<dynamic>> getOrLoadNotesList() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return await sharedNotesList();
    } else {
      return await apiNotesList();
    }
  }

  @observable
  NoteModel selectedNote = NoteModel();

  @action
  void handleItemSelection(NoteModel note) {
    selectedNote = note;
  }
}
