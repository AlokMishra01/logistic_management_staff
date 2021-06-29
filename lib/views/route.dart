import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants/colors.dart';
import '../constants/values.dart';
import '../widgets/general_button.dart';
import '../widgets/header.dart';
import 'route_order_detail_modal.dart';

class MapRoutes extends StatefulWidget {
  @override
  _MapRoutesState createState() => _MapRoutesState();
}

class _MapRoutesState extends State<MapRoutes> {
  String _selected = "Kathmandu";
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: BASE_PADDING),
        Header(title: 'Route'),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: BASE_PADDING,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Detailed route of selected location',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: DETAILS_TEXT - 2,
                    color: TEXT_BLACK,
                  ),
                ),
              ),
              SizedBox(width: BASE_PADDING / 4),
              Container(
                decoration: BoxDecoration(
                  color: FIELD_BACKGROUND,
                  borderRadius: BorderRadius.circular(RADIUS / 2),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: BASE_PADDING / 2,
                  vertical: BASE_PADDING / 4,
                ),
                child: DropdownButton<String>(
                  icon: Icon(CupertinoIcons.chevron_down, size: DETAILS_TEXT),
                  underline: Container(color: Colors.transparent),
                  isDense: true,
                  onChanged: (v) {
                    _selected = v ?? '';
                    setState(() {});
                  },
                  value: _selected,
                  items: <String>["Kathmandu", "Pokhara", "Dharan"]
                      .map<DropdownMenuItem<String>>(
                        (v) => DropdownMenuItem(
                          value: v,
                          child: Text(
                            ' $v ',
                            style: TextStyle(
                              fontSize: DETAILS_TEXT - 2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: BASE_PADDING),
        Expanded(
          child: Stack(
            children: [
              GoogleMap(
                myLocationEnabled: true,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(27.68830, 85.33556),
                  zoom: 5,
                ),
                onMapCreated: (controller) {
                  _controller.complete(controller);
                  controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(27.68830, 85.33556),
                        zoom: 15,
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: BASE_PADDING,
                left: BASE_PADDING,
                right: BASE_PADDING,
                child: Center(
                  child: GeneralButton(
                    color: Colors.green,
                    child: Text(
                      ' VIEW ALL ROUTES ',
                      style: TextStyle(
                        color: TEXT_WHITE,
                        fontWeight: FontWeight.bold,
                        fontSize: DETAILS_TEXT - 2,
                      ),
                    ),
                    onTab: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => RouteOrderDetailModal(),
                        isScrollControlled: true,
                        backgroundColor: TEXT_WHITE,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(RADIUS),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
