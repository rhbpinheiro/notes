import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:notes/app/shared/constants.dart';
import 'package:notes/app/shared/helpers/messages.dart';
import 'package:notes/app/shared/helpers/size_extensions.dart';
import 'package:notes/app/shared/utils/appRouter.dart';
import 'package:notes/app/shared/widgets/WidgetNoteCard.dart';
import 'package:notes/app/shared/widgets/widgetConfirmDialog.dart';
import 'package:notes/app/shared/widgets/widgetTextFormFieldAddNote.dart';
import 'package:notes/app/stores/connectionStore.dart';
import 'package:notes/app/stores/notesStore.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotesStore notesStore = NotesStore();
  final TextEditingController controller = TextEditingController();
  final ConnectionStore connectionStore = ConnectionStore();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Anotações',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => WidgetConfirmationDialog(
                  title: 'Atenção!',
                  message: 'Deseja Realmente Sair?',
                  onConfirm: () async {
                    Navigator.of(context).pop();
                    await Navigator.of(context)
                        .popAndPushNamed(AppRoutes.AUTH_OR_HOME);
                  },
                ),
              );
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
            children: [
              const SizedBox(
                height: 10,
              ),
              Observer(builder: (_) {
                return FutureBuilder(
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
                                        if (connectionStore.connectionStatus ==
                                            ConnectionStatus.connected) {
                                          notesStore.removeNotes(
                                            note.id!,
                                            context,
                                          );
                                        } else {
                                          Messages(context).showError(
                                            'Para realizar essa ação, é necessário estar conectado à internet.',
                                          );
                                        }
                                      },
                                      funcEdit: () async {
                                        if (notesStore.editIsvalid == false &&
                                            connectionStore.connectionStatus ==
                                                ConnectionStatus.connected) {
                                          notesStore.seteditIsvalid();
                                          notesStore.handleItemSelection(note);
                                        } else {
                                          Messages(context).showError(
                                            'Para realizar essa ação, é necessário estar conectado à internet.',
                                          );
                                        }
                                      },
                                      noteText: note.text!,
                                    );
                                  }),
                                )
                              : const Center(
                                  child: Text(
                                    'Sem Anotações',
                                  ),
                                );
                        }),
                      );
                    });
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
                      child: WidgetTextFormFieldAddNote(
                        controller: controller,
                        focusNode: _focusNode,
                        onChanged: notesStore.setNotes,
                        hintText: notesStore.editIsvalid
                            ? notesStore.selectedNote.text ??
                                'Digite seu texto.'
                            : 'Digite seu texto.',
                        suffixIcon: Visibility(
                          visible: notesStore.isFormValid,
                          child: InkWell(
                            onTap: () async {
                              if (notesStore.editIsvalid) {
                                notesStore.editNotes(
                                  notesStore.selectedNote.id!,
                                  notesStore.noteTitle,
                                  context,
                                );

                                controller.clear();
                              } else {
                                if (connectionStore.connectionStatus ==
                                    ConnectionStatus.connected) {
                                  notesStore.addNotes(
                                    notesStore.noteTitle,
                                    context,
                                  );
                                  controller.clear();
                                } else {
                                  Messages(context).showError(
                                    'Para realizar essa ação, é necessário estar conectado à internet.',
                                  );
                                }
                              }
                            },
                            child: Icon(
                              notesStore.editIsvalid ? Icons.save : Icons.add,
                            ),
                          ),
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
                  final Uri url = Uri.parse(
                    "https://www.google.com.br",
                  );
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
    );
  }
}
