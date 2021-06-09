part of 'repository_bloc.dart';

class RepositoryState {
  StateStatus? requestState;
  String? errorMessage;
  RepositoryEvent? currentAction;
  Repositories? repositories;

  RepositoryState({
    this.requestState,
    this.errorMessage,
    this.currentAction,
    this.repositories,
  });

  RepositoryState.initialState() {
    this.requestState = StateStatus.NONE;
    this.repositories = Repositories();
  }
}
