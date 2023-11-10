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
import 'package:notes/app/shared/utils/appRouter.dart';
import 'package:notes/app/shared/widgets/WidgetNoteCard.dart';
import 'package:notes/app/shared/widgets/WidgetTextFormField.dart';
import 'package:notes/app/shared/widgets/widgetConfirmDialog.dart';
import 'package:notes/app/stores/loginStore.dart';
import 'package:notes/app/stores/notesStore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NoteModel>? notes;

  NotesStore notesStore = NotesStore();
  LoginStore login = LoginStore();
  late List<String> userEmail;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    notesStore.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    print(login.email);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Anotações',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
            )
          ],
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
                  'Minhas Anotações',
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
                                if (notesStore.editIsvalid) {
                                  login.setLoading();
                                  notesStore.editNotes(
                                      notesStore.selectedNote.id!,
                                      notesStore.noteTitle);
                                  await Future.delayed(Duration(seconds: 2));
                                  login.setLoading();

                                  Messages(context).showSuccess(
                                      'Anotação editada com sucesso.');
                                  notesStore.setNotes('');
                                  notesStore.seteditIsvalid();
                                } else {
                                  await notesStore.addNotes();
                                }
                              },
                              child: Icon(notesStore.editIsvalid
                                  ? Icons.save
                                  : Icons.add),
                            ),
                      hintText: notesStore.editIsvalid
                          ? notesStore.selectedNote.text!
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
                          ? login.loagind
                              ? LoadingAnimationWidget.threeArchedCircle(
                                  color: Colors.green,
                                  size: 60,
                                )
                              : ListView.builder(
                                  itemCount: notesStore.noteList!.length,
                                  itemBuilder: ((context, index) {
                                    final note = notesStore.noteList[index];
                                    return WidgetNoteCard(
                                      funcDelete: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              WidgetConfirmationDialog(
                                            title: 'Atenção!',
                                            message:
                                                'Deseja Realmente Excluir?',
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
                                        notesStore.handleItemSelection(note);
                                      },
                                      noteText: "${note.text} == ${note.id}",
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
