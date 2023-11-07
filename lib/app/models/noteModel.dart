class NoteModel {
  final String id;
  final String text;

  NoteModel({required this.id, required this.text});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      text: json['text'],
    );
  }
}
