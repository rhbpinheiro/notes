import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:notes/app/models/noteModel.dart';
import 'package:notes/app/shared/constants.dart';
import 'package:notes/app/shared/helpers/messages.dart';
import 'package:notes/app/shared/helpers/size_extensions.dart';
import 'package:notes/app/shared/utils/appRouter.dart';
import 'package:notes/app/shared/widgets/WidgetNoteCard.dart';
import 'package:notes/app/shared/widgets/widgetConfirmDialog.dart';
import 'package:notes/app/stores/loginStore.dart';
import 'package:notes/app/stores/notesStore.dart';
import 'package:url_launcher/url_launcher.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
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
        body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: gradient,
              ),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                        future: notesStore.getOrLoadNotesList(),
                        builder: (context, snapshot) {
                          return Container(
                            width: context.screenWidth * .85,
                            height: context.screenHeight * .5,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Observer(builder: (context) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return LoadingAnimationWidget.threeArchedCircle(
                                  color: const Color(0xFF1f5466),
                                  size: 60,
                                );
                              }
                              return notesStore.noteList.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: notesStore.noteList.length,
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
                                                onConfirm: () {
                                                  notesStore
                                                      .removeNotes(note.id!);
                                                  Navigator.of(context).pop();

                                                  Messages(context).showSuccess(
                                                      'Anotação removida com sucesso.');
                                                },
                                              ),
                                            );
                                          },
                                          funcEdit: () async {
                                            if (notesStore.editIsvalid ==
                                                false) {
                                              notesStore.seteditIsvalid();
                                              notesStore
                                                  .handleItemSelection(note);
                                            }
                                          },
                                          noteText: note.text!,
                                        );
                                      }),
                                    )
                                  : const Center(
                                      child: Text('Sem Anotações'),
                                    );
                            }),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Observer(
                      builder: (_) {
                        return Container(
                          padding: const EdgeInsets.only(
                            left: 30,
                            right: 30,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 100,
                            ),
                            child: TextFormField(
                              maxLines: null,
                              keyboardType: TextInputType.text,
                              onChanged: notesStore.setNotes,
                              controller: controller,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: notesStore.editIsvalid
                                    ? notesStore.selectedNote.text
                                    : 'Digite seu texto.',
                                filled: true,
                                suffixIcon: !notesStore.isFormValid
                                    ? null
                                    : InkWell(
                                        onTap: () async {
                                          if (notesStore.editIsvalid) {
                                            login.setLoading();
                                            notesStore.editNotes(
                                                notesStore.selectedNote.id!,
                                                notesStore.noteTitle);
                                            Future.delayed(
                                                const Duration(seconds: 1));
                                            login.setLoading();

                                            Messages(context).showSuccess(
                                                'Anotação editada com sucesso.');

                                            notesStore.seteditIsvalid();
                                            controller.clear();
                                            notesStore.setNotes('');
                                          } else {
                                            login.setLoading();

                                            notesStore.addNotes();
                                            Future.delayed(
                                                const Duration(seconds: 1));
                                            login.setLoading();
                                            Messages(context).showSuccess(
                                                'Anotação adicionada com sucesso.');
                                            controller.clear();
                                            notesStore.setNotes('');
                                          }
                                        },
                                        child: Icon(notesStore.editIsvalid
                                            ? Icons.save
                                            : Icons.add),
                                      ),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF1f5466),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: context.screenWidth * 0.45,
                    ),
                    InkWell(
                      onTap: () {
                        final Uri url = Uri.parse("https://www.google.com.br");
                        launchUrl(url);
                      },
                      child: const Text(
                        'Política de Privacidade',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
