import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class MessageList extends StatefulWidget {
  MessageList({
    Key? key,
    required this.firestore,
    required this.valueNotifier,
  }) : super(key: key);

  final FirebaseFirestore firestore;
  final ValueNotifier<String?> valueNotifier;
  var mallObject;

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  String holder = "";
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
        stream: widget.firestore.collection('malls').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(
              child: const CupertinoActivityIndicator(),
            );

          return new Container(
            height: 60,
            width: MediaQuery.of(context).size.width *
                (Responsive.isDesktop(context) ? 0.35 : 0.4),
            //padding: EdgeInsets.only(bottom: 16.0),
            child: new InputDecorator(
              decoration: const InputDecoration(
                hintText: 'Choose an category',
                hintStyle: TextStyle(
                  color: primaryColor,
                  fontSize: 16.0,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.normal,
                ),
              ),
              child: DropdownButton(
                hint: Text("Choose Mall"),
                value: widget.mallObject,
                isDense: false,
                onChanged: (newValue) {
                  setState(() {
                    holder = newValue.toString();
                    print(newValue.toString());

                    widget.mallObject = newValue.toString();
                  });
                  widget.valueNotifier.value = newValue.toString();
                },
                items: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return new DropdownMenuItem<String>(
                      value: document['mallName'] ?? "",
                      child: new Text(document['mallName'] ?? ""));
                }).toList(),
              ),
            ),
          );
        });
  }
}
