// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notesStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotesStore on _NotesStoreBase, Store {
  late final _$notesAtom =
      Atom(name: '_NotesStoreBase.notes', context: context);

  @override
  String get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(String value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  late final _$_NotesStoreBaseActionController =
      ActionController(name: '_NotesStoreBase', context: context);

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
  String toString() {
    return '''
notes: ${notes}
    ''';
  }
}
