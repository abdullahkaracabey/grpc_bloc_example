part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
}

class FavoritesChanged extends FavoritesEvent {
  const FavoritesChanged(this.list);

  final List<PoiReply> list;

  @override
  List<Object> get props => [list];
}
