import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paintme/bloc/idea_bloc.dart';
import 'package:paintme/models/idea_repository.dart';
import 'package:paintme/widgets/idea_card.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ideas'),
      ),
      body: BlocBuilder<IdeaBloc, IdeaState>(
        builder: (context, state) {
          // if (state is IdeaStateNotInitialized) {
          //   return Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     ],
          //   );
          // } else if (state is IdeaStateFetched) {
          final repository = RepositoryProvider.of<IdeaRepository>(context);
          final ideas = repository.getList();
          return ListView.builder(
            itemCount: ideas.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/editor',
                      arguments: ideas[index]);
                },
                child: IdeaCard(idea: ideas[index]),
              );
            },
          );
          // }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/editor',
            arguments: RepositoryProvider.of<IdeaRepository>(context).getNew(),
          );
        },
      ),
    );
  }
}
