import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repo/app/common_widget/text_error.widget.dart';
import 'package:github_repo/bloc/repository/repository_bloc.dart';
import 'package:github_repo/enum/stateStatus.enum.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending Repos"),
        centerTitle: true,
      ),
      body: BlocBuilder<RepositoryBloc, RepositoryState>(
        builder: (context, state) {
          print(state.requestState);
          if (state.requestState == StateStatus.NONE) {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<RepositoryBloc>().add(LoadRepositories());
            // });
            return Container();
          } else if (state.requestState == StateStatus.LOADING) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.requestState == StateStatus.ERROR) {
            return TextErrorWidget(
              errorMessage: state.errorMessage,
              actionEvent: () =>
                  context.read<RepositoryBloc>().add(LoadRepositories()),
            );
          } else if (state.requestState == StateStatus.LOADED) {
            return Container(
              child: Text("done"),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
