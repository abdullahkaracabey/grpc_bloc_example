import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_bloc_example/src/favorites/bloc/favorites_bloc.dart';

import '../../generated/poi.pb.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  _onTapRemoveFromFavorites(BuildContext context, PoiReply item) {
    BlocProvider.of<FavoritesBloc>(context).addOrRemoveFromFavorites(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body:
          BlocBuilder<FavoritesBloc, FavoritesState>(builder: (context, state) {
        if (state.list.isEmpty) {
          return const Center(
            child: Text("No element"),
          );
        }

        return ListView.builder(
          itemCount: state.list.length,
          itemBuilder: (context, index) {
            final item = state.list[index];
            return ListTile(
              title: Text(item.name),
              trailing: TextButton(
                  child: Text("Kaldır"),
                  onPressed: () => _onTapRemoveFromFavorites(context, item)),
            );
          },
        );
      }),
    );
  }
}
