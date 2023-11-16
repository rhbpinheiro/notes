import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:notes/app/controller/noteController.dart';
import 'package:notes/app/models/noteModel.dart';
import 'package:notes/app/shared/helpers/messages.dart';
import 'package:notes/app/shared/widgets/widgetConfirmDialog.dart';
import 'package:notes/app/stores/connectionStore.dart';
import 'package:notes/app/stores/loginStore.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'notesStore.g.dart';

class NotesStore = _NotesStoreBase with _$NotesStore;

abstract class _NotesStoreBase with Store {
  ConnectionStore connectionStore = ConnectionStore();
  LoginStore login = LoginStore();

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
  Future<void> addNotes(String text, BuildContext context) async {
    login.setLoading();

    final addNote = await NoteController().addNote(text);

    Future.delayed(const Duration(seconds: 1));

    login.setLoading();

    Messages(context).showSuccess('Anotação adicionada com sucesso.');

    setNotes('');

    if (addNote != null) {
      noteList.insert(0, addNote);
      saveNotesList();
    }
  }

  @action
  Future<void> removeNotes(String noteId, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => WidgetConfirmationDialog(
        title: 'Atenção!',
        message: 'Deseja Realmente Excluir?',
        onConfirm: () async {
          await NoteController().delete(noteId);

          apiNotesList();

          saveNotesList();

          Navigator.of(context).pop();

          Messages(context).showSuccess(
            'Anotação removida com sucesso.',
          );
        },
      ),
    );
  }

  @action
  Future<void> editNotes(
    String noteId,
    String newText,
    BuildContext context,
  ) async {
    login.setLoading();

    await NoteController().update(noteId, newText);

    Future.delayed(const Duration(seconds: 1));

    login.setLoading();

    Messages(context).showSuccess('Anotação editada com sucesso.');

    seteditIsvalid();

    setNotes('');

    apiNotesList();
  }

  @action
  Future<List<dynamic>> apiNotesList() async {
    List<NoteModel> fetchedNotes = await NoteController().getAllNotes();
    noteList = ObservableList.of(fetchedNotes);
    saveNotesList();
    return fetchedNotes;
  }

  @action
  Future<void> saveNotesList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> notesListJson = noteList.map((note) {
      String encodedNote = jsonEncode(note.toJson());
      return utf8.decode(encodedNote.runes.toList());
    }).toList();

    await prefs.setStringList('notesList', notesListJson);
  }

  @observable
  List<NoteModel> loadedNotes = [];

  @action
  Future<List<dynamic>> sharedNotesList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> notesListJson = prefs.getStringList('notesList') ?? [];

    List<NoteModel> loadedNotes = notesListJson
        .map(
          (noteJson) => NoteModel.fromJson(
            jsonDecode(noteJson),
          ),
        )
        .toList();

    noteList = ObservableList.of(loadedNotes);

    return loadedNotes;
  }

  @action
  Future<List<dynamic>> getOrLoadNotesList() async {
    if (connectionStore.connectionStatus == ConnectionStatus.connected) {
      return await apiNotesList();
    } else {
      return await sharedNotesList();
    }
  }

  @observable
  NoteModel selectedNote = NoteModel();

  @action
  void handleItemSelection(NoteModel note) {
    selectedNote = note;
  }
}
