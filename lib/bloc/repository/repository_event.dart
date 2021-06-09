part of 'repository_bloc.dart';

@immutable
abstract class RepositoryEvent<T> {
  T? payload;
  RepositoryEvent({this.payload});
}

class LoadRepositories extends RepositoryEvent {
  LoadRepositories() : super();
}
