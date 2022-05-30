part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  const FavoritesState._({this.list = const <PoiReply>[]});

  const FavoritesState.empty() : this._();

  const FavoritesState.favoritesChanged(List<PoiReply> list)
      : this._(list: list);

  final List<PoiReply> list;

  @override
  List<Object> get props => [list];
}
