import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:github_repo/enum/stateStatus.enum.dart';
import 'package:github_repo/models/repository.model.dart';
import 'package:meta/meta.dart';

part 'repository_event.dart';
part 'repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  RepositoryBloc(RepositoryState repositoryInitial) : super(repositoryInitial);

  @override
  Stream<RepositoryState> mapEventToState(
    RepositoryEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
