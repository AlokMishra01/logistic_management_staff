import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logistic_management_staff/constants/values.dart';

class MapPage extends StatefulWidget {
  final LatLng latLngFrom;
  final LatLng latLngTo;

  const MapPage({
    Key? key,
    required this.latLngFrom,
    required this.latLngTo,
  }) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: widget.latLngFrom,
            zoom: 5.0,
          ),
          markers: <Marker>{
            Marker(
              markerId: MarkerId(widget.latLngFrom.toString()),
              position: widget.latLngFrom,
            ),
            Marker(
              markerId: MarkerId(widget.latLngTo.toString()),
              position: widget.latLngTo,
            ),
          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: widget.latLngFrom,
                  zoom: 13.0,
                ),
              ),
            );
          },
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(BASE_PADDING),
            child: Material(
              color: Colors.transparent,
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.2),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
