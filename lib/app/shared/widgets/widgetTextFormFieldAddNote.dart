// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetTextFormFieldAddNote extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final FocusNode focusNode;
  final String hintText;
  final Widget suffixIcon;
  const WidgetTextFormFieldAddNote({
    Key? key,
    required this.controller,
    this.onChanged,
    required this.focusNode,
    required this.hintText,
    required this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      keyboardType: TextInputType.text,
      onChanged: onChanged,
      controller: controller,
      autofocus: true,
      focusNode: focusNode,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        suffixIcon: suffixIcon,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF1f5466),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
      ),
    );
  }
}

// ConstrainedBox(
//                             constraints: const BoxConstraints(
//                               maxHeight: 100,
//                             ),
//                             child: TextFormField(
//                               maxLines: null,
//                               keyboardType: TextInputType.text,
//                               onChanged: notesStore.setNotes,
//                               controller: controller,
//                               autofocus: true,
//                               focusNode: _focusNode,
//                               textAlign: TextAlign.center,
//                               decoration: InputDecoration(
//                                 hintText: notesStore.editIsvalid
//                                     ? notesStore.selectedNote.text
//                                     : 'Digite seu texto.',
//                                 filled: true,
//                                 suffixIcon: !notesStore.isFormValid
//                                     ? null
//                                     : InkWell(
//                                         onTap: () async {
//                                           if (notesStore.editIsvalid) {
//                                             notesStore.editNotes(
//                                               notesStore.selectedNote.id!,
//                                               notesStore.noteTitle,
//                                               context,
//                                             );

//                                             controller.clear();
//                                           } else {
//                                             if (connectionStore
//                                                     .connectionStatus ==
//                                                 ConnectionStatus.connected) {
//                                               notesStore.addNotes(
//                                                 notesStore.noteTitle,
//                                                 context,
//                                               );
//                                               controller.clear();
//                                             } else {
//                                               Messages(context).showError(
//                                                 'Para realizar essa ação, é necessário estar conectado à internet.',
//                                               );
//                                             }
//                                           }
//                                         },
//                                         child: Icon(notesStore.editIsvalid
//                                             ? Icons.save
//                                             : Icons.add),
//                                       ),
//                                 fillColor: Colors.white,
//                                 border: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                     color: Color(0xFF1f5466),
//                                   ),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     vertical: 10, horizontal: 10),
//                               ),
//                             ),
//                           ),