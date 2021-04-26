import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:paintme/bloc/idea_bloc.dart';
import 'package:paintme/models/idea.dart';

class IdeaCard extends StatelessWidget {
  final Idea idea;

  IdeaCard({Key key, this.idea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.0),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    idea.uid.toString() + '. ' + idea.title,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Text(
                  DateFormat('yyyy-mm-dd').format(idea.created),
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                PopupMenuButton(
                  onSelected: (select) {
                    BlocProvider.of<IdeaBloc>(context)
                      ..add(IdeaEventDeleting(idea));
                  },
                  itemBuilder: (context) => <PopupMenuEntry>[
                    const PopupMenuItem(
                      value: 0,
                      child: Text('delete'),
                    )
                  ],
                )
              ],
            ),
            IdeaCardShort(
              title: 'As a',
              titleColor: Colors.red,
              text: idea.role,
            ),
            IdeaCardShort(
              title: 'I want',
              titleColor: Colors.green,
              text: idea.goal,
            ),
            IdeaCardShort(
              title: 'So that',
              titleColor: Colors.blue,
              text: idea.value,
            ),
          ],
        ),
      ),
    );
  }
}

class IdeaCardShort extends StatelessWidget {
  final title;
  final titleColor;
  final text;

  const IdeaCardShort({Key key, this.title, this.titleColor, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            style: TextStyle(
              color: Colors.blueGrey,
            ),
          ),
        )
      ],
    );
  }
}
