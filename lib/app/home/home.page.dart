import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repo/app/common_widget/text_error.widget.dart';
import 'package:github_repo/bloc/repository/repository_bloc.dart';
import 'package:github_repo/enum/stateStatus.enum.dart';
import 'package:github_repo/models/repository.model.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
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
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.repositories?.items?.length,
                itemBuilder: (context, index) {
                  Item? repo = state.repositories?.items?[index];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(repo?.name ?? ""),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            repo?.description ?? "no description found",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 5, 8, 0),
                                  child: FadeInImage.assetNetwork(
                                    width: _screenWidth * 0.08,
                                    height: _screenHeight * 0.12,
                                    fadeInDuration: Duration(seconds: 1),
                                    placeholder: "assets/images/github.png",
                                    image: repo?.owner?.avatarUrl ?? "",
                                  ),
                                ),
                                Text(repo?.owner?.login ?? "No login found")
                              ],
                            ),
                            TextButton.icon(
                              onPressed: null,
                              label: Text(
                                NumberFormat.compact().format(double.parse(
                                    repo?.stargazersCount.toString() ?? "1")),
                                style: TextStyle(color: Colors.red),
                              ),
                              icon: Icon(
                                Icons.star_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
