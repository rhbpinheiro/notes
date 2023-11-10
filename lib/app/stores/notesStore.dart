import 'package:mobx/mobx.dart';
import 'package:notes/app/controller/noteController.dart';
import 'package:notes/app/models/noteModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      // noteList = ObservableList.of([...noteList, addedNote]);
      noteList.insert(0, addedNote);
    } else {
      print("Erro ao adicionar a nota à API.");
    }
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
    List<NoteModel> fetchedNotes = await NoteController().getAllNotes();

    noteList = ObservableList.of(fetchedNotes);

    return fetchedNotes;
  }

  @observable
  NoteModel selectedNote = NoteModel();

  @action
  void handleItemSelection(NoteModel note) {
    selectedNote = note;
  }
}
