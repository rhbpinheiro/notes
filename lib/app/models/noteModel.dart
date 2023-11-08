  class NoteModel {
    String? text;
    String? id;
  
    NoteModel({this.text, this.id});
  
    NoteModel.fromJson(Map<String, dynamic> json) {
      text = json['text'];
      id = json['id'];
    }
  
    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['text'] = this.text;
      data['id'] = this.id;
      return data;
    }
  }
  
