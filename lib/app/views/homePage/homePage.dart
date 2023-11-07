import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobx/mobx.dart';
import 'package:notes/app/controller/noteController.dart';
import 'package:notes/app/models/noteModel.dart';
import 'package:notes/app/shared/constants.dart';
import 'package:notes/app/shared/helpers/messages.dart';
import 'package:notes/app/shared/helpers/size_extensions.dart';
import 'package:notes/app/shared/widgets/WidgetNoteCard.dart';
import 'package:notes/app/shared/widgets/WidgetTextFormField.dart';
import 'package:notes/app/shared/widgets/widgetConfirmDialog.dart';
import 'package:notes/app/stores/notesStore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NoteModel>? notes;
  NotesStore notesStore = NotesStore();
  Future<List<NoteModel>> getNotes() async {
    notes = await NoteController().getAllNotes();
    return notes!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1f5466),
      ),
      body: FutureBuilder(
        future: getNotes(),
        builder: (context, snapshot) {
          return Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: gradient,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'My Notes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Observer(builder: (_) {
                    return Container(
                      width: context.screenWidth * .85,
                      height: context.screenHeight * .5,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.builder(
                        itemCount: notes!.length,
                        itemBuilder: ((context, index) {
                          final note = notes![index];
                          return WidgetNoteCard(
                            funcDelete: () async {
                              showDialog(
                                context: context,
                                builder: (context) => WidgetConfirmationDialog(
                                  title: 'Atenção!',
                                  message: 'Deseja Realmente Excluir?',
                                  onConfirm: () async {
                                    await NoteController().delete(note.id);
                                    Navigator.of(context).pop();
                                    Messages(context).showSuccess(
                                        'Anotação removida com sucesso.');
                                  },
                                ),
                              );
                            },
                            funcEdit: () {
                              showDialog(
                                context: context,
                                builder: (context) => WidgetConfirmationDialog(
                                  title: 'Atenção!',
                                  message: 'Deseja Confirmar a Edição?',
                                  onConfirm: () async {
                                    await NoteController().delete(note.id);
                                    Navigator.of(context).pop();
                                    Messages(context).showSuccess(
                                        'Anotação Editada com sucesso.');
                                  },
                                ),
                              );
                              notesStore.setNotes(note.text);
                              notesStore.seteditIsvalid;
                              print(notesStore.notes);
                            },
                            noteText: note.text,
                          );
                        }),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Observer(
                    builder: (_) {
                      return WidgetTextFormField(
                        title: '',
                        controller: TextEditingController(),
                        obscureText: false,
                        autofocus: true,
                        readOnly: notesStore.editIsvalid,
                        suffixIcon: notesStore.notes == ''
                            ? null
                            : InkWell(
                                onTap: () async {
                                  notesStore.setNotes(notesStore.notes);
                                  await NoteController()
                                      .addNote(notesStore.notes);

                                  Messages(context).showSuccess(
                                      'Anotação enviada com sucesso.');
                                },
                                child: const Icon(
                                  Icons.add,
                                ),
                              ),
                        hintText: notesStore.notes == ''
                            ? 'Digite seu texto'
                            : notesStore.notes,
                        onChanged: notesStore.setNotes,
                      );
                    },
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.2,
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Política de Privacidade',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
