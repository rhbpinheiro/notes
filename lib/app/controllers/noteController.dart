import 'package:mobx/mobx.dart';
part 'notecontroller.g.dart';

class NoteController = _NoteControllerBase with _$NoteController;

abstract class _NoteControllerBase with Store {
  @observable
  String notes = '';
  @action
  void setNotes(String value) => notes = value;
}
