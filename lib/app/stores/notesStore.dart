import 'package:mobx/mobx.dart';
part 'notesStore.g.dart';

class NotesStore = _NotesStoreBase with _$NotesStore;

abstract class _NotesStoreBase with Store {
  @observable
  String notes = '';

  @action
  void setNotes(String value) => notes = value;

  @observable
  bool editIsvalid = false;

  @action
  void seteditIsvalid() {
    editIsvalid = !editIsvalid;
  }
}
