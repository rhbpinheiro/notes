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
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AutoSizeText(
                  noteText,
                  minFontSize: 12,
                  maxLines: 5,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: funcEdit,
                        child: Icon(
                          Icons.border_color_sharp,
                          size: 25,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        height: 2,
                        width: 30,
                        color: Colors.black87,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: funcDelete,
                    child: Icon(
                      Icons.cancel,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider()
        ],
      ),
    );
    ;
  }
}
