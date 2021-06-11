part of 'repository_bloc.dart';

class RepositoryState {
  StateStatus? requestState;
  String? errorMessage;
  RepositoryEvent? currentAction;
  Repositories? repositories;
  // List<Item?> repo = [];

  RepositoryState({
    this.requestState,
    this.errorMessage,
    this.currentAction,
    this.repositories,
    // this.repo,
  });

  RepositoryState.initialState() {
    this.requestState = StateStatus.NONE;
    this.repositories = Repositories();
    // this.repo = [];
  }
}
