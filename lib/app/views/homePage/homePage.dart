import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobx/mobx.dart';
import 'package:notes/app/controller/noteController.dart';
import 'package:notes/app/models/noteModel.dart';
import 'package:notes/app/shared/constants.dart';
import 'package:notes/app/shared/helpers/loader.dart';
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
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    notesStore.getNotesList();
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
        body: Container(
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
                Observer(
                  builder: (_) {
                    return WidgetTextFormField(
                      keyboardType: TextInputType.text,
                      title: '',
                      controller: controller,
                      obscureText: false,
                      autofocus: true,
                      readOnly: false,
                      suffixIcon: !notesStore.isFormValid
                          ? null
                          : InkWell(
                              onTap: () async {
                                print(controller.text);
                                print("mobx==== ${notesStore.noteTitle}");
                                print(notesStore.editIsvalid);

                                if (notesStore.editIsvalid) {
                                  notesStore.getNotesList();
                                  notesStore.seteditIsvalid();
                                  controller.clear();
                                  notesStore.setNotes('');
                                } else {
                                  await notesStore.addNotes();
                                }
                              },
                              child: Icon(notesStore.editIsvalid
                                  ? Icons.save
                                  : Icons.add),
                            ),
                      hintText: notesStore.editIsvalid
                          ? notesStore.noteTitle
                          : 'Digite seu texto',
                      onChanged: notesStore.setNotes,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Builder(builder: (context) {
                  return Container(
                    width: context.screenWidth * .85,
                    height: context.screenHeight * .5,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Observer(builder: (context) {
                      return (notesStore.noteList!.length != 0)
                          ? ListView.builder(
                              itemCount: notesStore.noteList!.length,
                              itemBuilder: ((context, index) {
                                final note = notesStore.noteList![index];
                                return WidgetNoteCard(
                                  funcDelete: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          WidgetConfirmationDialog(
                                        title: 'Atenção!',
                                        message: 'Deseja Realmente Excluir?',
                                        onConfirm: () async {
                                          await notesStore
                                              .removeNotes(note.id!);
                                          Navigator.of(context).pop();
                                          Messages(context).showSuccess(
                                              'Anotação removida com sucesso.');
                                        },
                                      ),
                                    );
                                  },
                                  funcEdit: () async {
                                    notesStore.seteditIsvalid();
                                    if (notesStore.noteList != null) {
                                      // controller.text =
                                      //     selectedNote.first.text!;
                                    }
                                  },
                                  noteText: note.text!,
                                );
                              }),
                            )
                          : Center(child: Text('Sem Anotações.'));
                    }),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: context.screenHeight * 0.1 / 2,
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
        ));
  }
}
