import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grpc_bloc_example/src/app_state/app_state.dart';
import 'package:grpc_bloc_example/src/authentication/authentication.dart';
import 'package:grpc_bloc_example/src/favorites/bloc/favorites_bloc.dart';
import 'package:grpc_bloc_example/src/generated/poi.pb.dart';
import 'package:grpc_bloc_example/src/map/bloc/map_bloc.dart';
import 'package:grpc_bloc_example/src/route/app_page.dart';
import 'package:grpc_bloc_example/src/route/navigation_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:collection/collection.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class MapPage extends AppPage {
  MapPage(Map<String, dynamic> args) : super(args: args);
  GoogleMapController? _mapController;

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
        northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }

  _mapToPosition(List<LatLng> list) {
    debugPrint("controller is created, animation camera ok");
    _mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(boundsFromLatLngList(list), 32));
  }

  _onTapPoi(BuildContext context, PoiReply location) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(location.name,
                        textAlign: TextAlign.left, style: textTheme.headline5),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(location.openNow ? "Açık" : "Kapalı",
                          textAlign: TextAlign.left,
                          style: textTheme.bodyText2),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => _onTapWebsite(context, location),
                      child: Text("Website", style: textTheme.bodyText2),
                    ),
                    IconButton(
                        onPressed: () => _onTabFavorite(context, location),
                        icon: BlocBuilder<FavoritesBloc, FavoritesState>(
                            builder: (context, state) {
                          final existLocation = state.list.firstWhereOrNull(
                              (element) => element == location);

                          return Icon(existLocation == null
                              ? Icons.favorite_outline
                              : Icons.favorite);
                        }))
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MapBloc, MapState>(
          listener: ((context, state) {}),
          builder: (context, state) {
            var locations = state.locations;

            debugPrint("Map Locations length: ${locations?.length}");

            if (locations == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var markers = <MarkerId, Marker>{};

            var latLngList =
                locations.map<LatLng>((e) => LatLng(e.lat, e.lon)).toList();

            _mapToPosition(latLngList);

            for (var location in locations) {
              MarkerId markerId = MarkerId("${location.lat}${location.lon}");
              LatLng position = LatLng(location.lat, location.lon);
              Marker marker = Marker(
                  markerId: markerId,
                  // icon: icon,
                  position: position,
                  draggable: false,
                  onTap: () => _onTapPoi(context, location));
              markers[markerId] = marker;
            }

            return Stack(
              children: [
                GoogleMap(
                    compassEnabled: false,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,
                    mapType: MapType.normal,
                    buildingsEnabled: false,
                    indoorViewEnabled: false,
                    tiltGesturesEnabled: false,
                    zoomControlsEnabled: false,
                    // zoomControlsEnabled: false,
                    trafficEnabled: true,
                    // rotateGesturesEnabled: false,
                    // scrollGesturesEnabled: false,
                    // minMaxZoomPreference: const MinMaxZoomPreference(13, 20),
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(0, 0),
                      zoom: 13,
                    ),
                    markers: Set<Marker>.of(markers.values),
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                      debugPrint("map controller created");

                      if (markers.values.isNotEmpty) {
                        _mapToPosition(latLngList);
                      }
                    },
                    onTap: (location) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onCameraIdle: () {
                      debugPrint("Camera is on idle");
                    },
                    onCameraMove: (CameraPosition position) {
                      debugPrint("Camera is on move");
                    }),
                Positioned(
                    top: MediaQuery.of(context).viewPadding.top + 16,
                    right: 16,
                    child: ElevatedButton(
                        onPressed: () => _onTabFavorites(context),
                        child: const Text("Favorites")))
              ],
            );
          }),
    );
  }

  _onTabFavorites(BuildContext context) async {
    BlocProvider.of<NavigationCubit>(context).push("/favorites");
  }

  _onTabFavorite(BuildContext context, PoiReply location) async {
    BlocProvider.of<FavoritesBloc>(context).addOrRemoveFromFavorites(location);
  }

  _onTapWebsite(BuildContext context, PoiReply location) async {
    final url = location.website;
    if (!await launchUrl(Uri.parse(url))) {
      // onError()
    }
  }
}
