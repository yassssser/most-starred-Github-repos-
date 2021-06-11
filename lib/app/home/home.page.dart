import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repo/app/common_widget/text_error.widget.dart';
import 'package:github_repo/bloc/repository/repository_bloc.dart';
import 'package:github_repo/enum/stateStatus.enum.dart';
import 'package:github_repo/models/repository.model.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  int _page = 1;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ++_page;
        context.read<RepositoryBloc>().add(LoadRepositories(page: _page));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

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
          if (state.requestState == StateStatus.NONE) {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<RepositoryBloc>().add(LoadRepositories(page: _page));
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
              color: Colors.grey[300],
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: state.repositories?.items?.length,
                itemBuilder: (context, index) {
                  if (state.repositories?.items?.length == 0)
                    return Text("No repo found for this month :)");

                  Item? repo = state.repositories?.items?[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3.0,
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
