part of 'repository_bloc.dart';

abstract class RepositoryEvent<T> {
  T? payload;
  RepositoryEvent({this.payload});
}

class LoadRepositories extends RepositoryEvent {
  LoadRepositories() : super();
}
