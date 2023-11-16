import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:notes/app/models/noteModel.dart';
import 'package:notes/app/shared/constants.dart';

class NoteController {
  Future<List<NoteModel>> getAllNotes() async {
    final response = await http.get(Uri.parse('$apiUrl/notes'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((note) => NoteModel.fromJson(note)).toList();
    } else {
      throw Exception('Erro ao buscar notas da API');
    }
  }

  Future<NoteModel> addNote(String text) async {
    final response = await http.post(
      Uri.parse('$apiUrl/notes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'text': text,
      }),
    );

    if (response.statusCode == 201) {
      return NoteModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao adicionar nota à API');
    }
  }

  Future<void> delete(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/notes/$id'));

    if (response.statusCode == 200) {
    } else {
      throw Exception('Erro ao excluir nota da API');
    }
  }

  Future<NoteModel?> update(String id, String newText) async {
    final response = await http.put(
      Uri.parse('$apiUrl/notes/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'text': newText,
      }),
    );

    if (response.statusCode == 200) {
      return NoteModel.fromJson(json.decode(response.body));
    } else {
      print('Erro ao atualizar nota na API: ${response.statusCode}');
      return null;
    }
  }
}
