import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:github_repo/enum/stateStatus.enum.dart';
import 'package:github_repo/models/repository.model.dart';
import 'package:github_repo/services/github.serice.dart';
import 'package:meta/meta.dart';

part 'repository_event.dart';
part 'repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  RepositoryBloc(RepositoryState repositoryInitial) : super(repositoryInitial);

  GithubService get githubService => GetIt.I<GithubService>();

  @override
  Stream<RepositoryState> mapEventToState(
    RepositoryEvent event,
  ) async* {
    if (event is LoadRepositories) {
      yield RepositoryState(requestState: StateStatus.LOADING);

      try {
        final Repositories data = await githubService.getRepositories();

        RepositoryState repositoryState = RepositoryState(
          requestState: StateStatus.LOADED,
          repositories: data,
          currentAction: event,
        );
        yield repositoryState;
      } catch (e) {
        yield RepositoryState(
          requestState: StateStatus.ERROR,
          errorMessage: e.toString(),
          currentAction: event,
        );
      }
    }
  }
}
