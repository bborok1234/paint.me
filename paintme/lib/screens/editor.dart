import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paintme/bloc/idea_bloc.dart';
import 'package:paintme/models/idea.dart';

class Editor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Idea idea = ModalRoute.of(context).settings.arguments as Idea;
    StringBuffer title = StringBuffer(idea.title);
    StringBuffer role = StringBuffer(idea.role);
    StringBuffer goal = StringBuffer(idea.goal);
    StringBuffer value = StringBuffer(idea.value);

    onSaveIdea() {
      idea.title = title.toString();
      idea.role = role.toString();
      idea.goal = goal.toString();
      idea.value = value.toString();
      BlocProvider.of<IdeaBloc>(context)..add(IdeaEventSaving(idea));
      Navigator.of(context).pop();
    }

    var appbar = AppBar(
      title: Text('Add your idea'),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () {
              onSaveIdea();
            },
            child: Icon(Icons.save),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              appbar.preferredSize.height * 1.5,
          child: Column(
            children: <Widget>[
              IdeaEditCard(title: 'Title', buf: title, flex: 1),
              IdeaEditCard(title: 'As a', buf: role, flex: 3),
              IdeaEditCard(title: 'I want', buf: goal, flex: 3),
              IdeaEditCard(title: 'So that', buf: value, flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class IdeaEditCard extends StatefulWidget {
  final String title;
  final StringBuffer buf;
  final int flex;

  const IdeaEditCard({Key key, this.title, this.buf, this.flex})
      : super(key: key);

  @override
  _IdeaEditCardState createState() => _IdeaEditCardState();
}

class _IdeaEditCardState extends State<IdeaEditCard> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(
      text: widget.buf.toString(),
    );
    _controller.addListener(() {
      widget.buf.clear();
      widget.buf.write(_controller.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Container(
        padding: EdgeInsets.all(10),
        child: TextField(
          maxLines: 100,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: widget.title,
          ),
          controller: _controller,
        ),
      ),
    );
  }
}
