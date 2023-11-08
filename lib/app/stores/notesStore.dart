import 'package:mobx/mobx.dart';
import 'package:notes/app/controller/noteController.dart';
import 'package:notes/app/models/noteModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'notesStore.g.dart';

class NotesStore = _NotesStoreBase with _$NotesStore;

abstract class _NotesStoreBase with Store {
  static const String notesKey = 'notesList';

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
  List<NoteModel>? noteList = [];

  @action
  Future<void> addNotes() async {
    final newNote = NoteModel(text: noteTitle);
    noteList = List.from(noteList!..add(newNote));
    await NoteController()
      ..addNote(newNote.text!);
  }

  @action
  Future<void> removeNotes(String noteId) async {
    await NoteController().delete(noteId);
    getNotesList();
  }

  @action
  Future<void> editNotes(String noteId, String newText) async {
    await NoteController().update(noteId, newText);
    getNotesList();
  }

  @action
  Future<List<dynamic>> getNotesList() async {
    noteList = await NoteController().getAllNotes();
    return noteList!;
  }
}
