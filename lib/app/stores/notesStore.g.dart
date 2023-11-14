// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notesStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotesStore on _NotesStoreBase, Store {
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_NotesStoreBase.isFormValid'))
          .value;

  late final _$loagindNoteAtom =
      Atom(name: '_NotesStoreBase.loagindNote', context: context);

  @override
  bool get loagindNote {
    _$loagindNoteAtom.reportRead();
    return super.loagindNote;
  }

  @override
  set loagindNote(bool value) {
    _$loagindNoteAtom.reportWrite(value, super.loagindNote, () {
      super.loagindNote = value;
    });
  }

  late final _$noteTitleAtom =
      Atom(name: '_NotesStoreBase.noteTitle', context: context);

  @override
  String get noteTitle {
    _$noteTitleAtom.reportRead();
    return super.noteTitle;
  }

  @override
  set noteTitle(String value) {
    _$noteTitleAtom.reportWrite(value, super.noteTitle, () {
      super.noteTitle = value;
    });
  }

  late final _$editIsvalidAtom =
      Atom(name: '_NotesStoreBase.editIsvalid', context: context);

  @override
  bool get editIsvalid {
    _$editIsvalidAtom.reportRead();
    return super.editIsvalid;
  }

  @override
  set editIsvalid(bool value) {
    _$editIsvalidAtom.reportWrite(value, super.editIsvalid, () {
      super.editIsvalid = value;
    });
  }

  late final _$noteListAtom =
      Atom(name: '_NotesStoreBase.noteList', context: context);

  @override
  ObservableList<NoteModel> get noteList {
    _$noteListAtom.reportRead();
    return super.noteList;
  }

  @override
  set noteList(ObservableList<NoteModel> value) {
    _$noteListAtom.reportWrite(value, super.noteList, () {
      super.noteList = value;
    });
  }

  late final _$selectedNoteAtom =
      Atom(name: '_NotesStoreBase.selectedNote', context: context);

  @override
  NoteModel get selectedNote {
    _$selectedNoteAtom.reportRead();
    return super.selectedNote;
  }

  @override
  set selectedNote(NoteModel value) {
    _$selectedNoteAtom.reportWrite(value, super.selectedNote, () {
      super.selectedNote = value;
    });
  }

  late final _$addNotesAsyncAction =
      AsyncAction('_NotesStoreBase.addNotes', context: context);

  @override
  Future<void> addNotes() {
    return _$addNotesAsyncAction.run(() => super.addNotes());
  }

  late final _$removeNotesAsyncAction =
      AsyncAction('_NotesStoreBase.removeNotes', context: context);

  @override
  Future<void> removeNotes(String noteId) {
    return _$removeNotesAsyncAction.run(() => super.removeNotes(noteId));
  }

  late final _$editNotesAsyncAction =
      AsyncAction('_NotesStoreBase.editNotes', context: context);

  @override
  Future<void> editNotes(String noteId, String newText) {
    return _$editNotesAsyncAction.run(() => super.editNotes(noteId, newText));
  }

  late final _$apiNotesListAsyncAction =
      AsyncAction('_NotesStoreBase.apiNotesList', context: context);

  @override
  Future<List<dynamic>> apiNotesList() {
    return _$apiNotesListAsyncAction.run(() => super.apiNotesList());
  }

  late final _$saveNotesListAsyncAction =
      AsyncAction('_NotesStoreBase.saveNotesList', context: context);

  @override
  Future<void> saveNotesList() {
    return _$saveNotesListAsyncAction.run(() => super.saveNotesList());
  }

  late final _$sharedNotesListAsyncAction =
      AsyncAction('_NotesStoreBase.sharedNotesList', context: context);

  @override
  Future<List<dynamic>> sharedNotesList() {
    return _$sharedNotesListAsyncAction.run(() => super.sharedNotesList());
  }

  late final _$getOrLoadNotesListAsyncAction =
      AsyncAction('_NotesStoreBase.getOrLoadNotesList', context: context);

  @override
  Future<List<dynamic>> getOrLoadNotesList() {
    return _$getOrLoadNotesListAsyncAction
        .run(() => super.getOrLoadNotesList());
  }

  late final _$_NotesStoreBaseActionController =
      ActionController(name: '_NotesStoreBase', context: context);

  @override
  void setLoading() {
    final _$actionInfo = _$_NotesStoreBaseActionController.startAction(
        name: '_NotesStoreBase.setLoading');
    try {
      return super.setLoading();
    } finally {
      _$_NotesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNotes(String value) {
    final _$actionInfo = _$_NotesStoreBaseActionController.startAction(
        name: '_NotesStoreBase.setNotes');
    try {
      return super.setNotes(value);
    } finally {
      _$_NotesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void seteditIsvalid() {
    final _$actionInfo = _$_NotesStoreBaseActionController.startAction(
        name: '_NotesStoreBase.seteditIsvalid');
    try {
      return super.seteditIsvalid();
    } finally {
      _$_NotesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleItemSelection(NoteModel note) {
    final _$actionInfo = _$_NotesStoreBaseActionController.startAction(
        name: '_NotesStoreBase.handleItemSelection');
    try {
      return super.handleItemSelection(note);
    } finally {
      _$_NotesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loagindNote: ${loagindNote},
noteTitle: ${noteTitle},
editIsvalid: ${editIsvalid},
noteList: ${noteList},
selectedNote: ${selectedNote},
isFormValid: ${isFormValid}
    ''';
  }
}
