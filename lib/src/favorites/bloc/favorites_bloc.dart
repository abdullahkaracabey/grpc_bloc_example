import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:grpc_bloc_example/src/generated/poi.pb.dart';
import 'package:collection/collection.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(const FavoritesState.empty()) {
    on<FavoritesChanged>(_onFavoritesChanged);
  }

  @override
  Future<void> close() {
    return super.close();
  }

  void _onFavoritesChanged(
    FavoritesChanged event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesState.favoritesChanged(event.list));
  }

  void addOrRemoveFromFavorites(PoiReply location) {
    var existLocation =
        state.list.firstWhereOrNull((element) => element == location);
    var newList = List.of(state.list);
    if (existLocation != null) {
      newList.remove(existLocation);
    } else {
      newList.add(location);
    }
    _onFavoriteChange(location, isAdded: existLocation == null);
    emit(FavoritesState.favoritesChanged(newList));
  }

  void _onFavoriteChange(PoiReply location, {bool isAdded = true}) {
    try {
      FirebaseAnalytics.instance.logEvent(
          name: isAdded ? "OnFavoritesAdded" : "FromFavoritesRemoved",
          parameters: {"locationName": location.name});
    } catch (e) {}
  }
}
