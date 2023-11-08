// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class WidgetNoteCard extends StatelessWidget {
  final VoidCallback funcDelete;
  final VoidCallback funcEdit;
  final String noteText;
  const WidgetNoteCard({
    Key? key,
    required this.funcDelete,
    required this.funcEdit,
    required this.noteText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(1, 0), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AutoSizeText(
              noteText,
              minFontSize: 8,
              maxLines: 3,
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: funcEdit,
                child: Icon(
                  Icons.edit_note,
                  size: 20,
                  color: Colors.blue[300],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: funcDelete,
                child: Icon(
                  Icons.delete_forever,
                  size: 20,
                  color: Colors.red[300],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}
