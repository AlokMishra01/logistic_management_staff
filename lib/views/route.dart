import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logistic_management_staff/controllers/geo_locator_controller.dart';
import 'package:logistic_management_staff/controllers/route_controller.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/values.dart';
import '../widgets/header.dart';

class MapRoutes extends StatefulWidget {
  const MapRoutes({Key? key}) : super(key: key);

  @override
  _MapRoutesState createState() => _MapRoutesState();
}

class _MapRoutesState extends State<MapRoutes> {
  // String _selected = "Kathmandu";
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final location = context.watch<GeoLocatorController>();
    final route = context.watch<RouteController>();

    return Column(
      children: [
        Header(
          title: 'Route',
          trailing: route.loadingVehicle
              ? const Padding(
                  padding: EdgeInsets.all(BASE_PADDING),
                  child: SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: CircularProgressIndicator(),
                  ),
                )
              : IconButton(
                  onPressed: () => route.getVechile(),
                  icon: const Icon(
                    Icons.wifi_protected_setup_rounded,
                    color: BUTTON_BLUE,
                  ),
                ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(
        //     horizontal: BASE_PADDING,
        //   ),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Expanded(
        //         child: Text(
        //           'Detailed route of selected location',
        //           style: TextStyle(
        //             fontWeight: FontWeight.w600,
        //             fontSize: DETAILS_TEXT - 2,
        //             color: TEXT_BLACK,
        //           ),
        //         ),
        //       ),
        //       SizedBox(width: BASE_PADDING / 4),
        //       Container(
        //         decoration: BoxDecoration(
        //           color: FIELD_BACKGROUND,
        //           borderRadius: BorderRadius.circular(RADIUS / 2),
        //         ),
        //         padding: const EdgeInsets.symmetric(
        //           horizontal: BASE_PADDING / 2,
        //           vertical: BASE_PADDING / 4,
        //         ),
        //         child: DropdownButton<String>(
        //           icon: Icon(CupertinoIcons.chevron_down, size: DETAILS_TEXT),
        //           underline: Container(color: Colors.transparent),
        //           isDense: true,
        //           onChanged: (v) {
        //             _selected = v ?? '';
        //             setState(() {});
        //           },
        //           value: _selected,
        //           items: <String>["Kathmandu", "Pokhara", "Dharan"]
        //               .map<DropdownMenuItem<String>>(
        //                 (v) => DropdownMenuItem(
        //                   value: v,
        //                   child: Text(
        //                     ' $v ',
        //                     style: TextStyle(
        //                       fontSize: DETAILS_TEXT - 2,
        //                       fontWeight: FontWeight.w600,
        //                     ),
        //                   ),
        //                 ),
        //               )
        //               .toList(),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        // SizedBox(height: BASE_PADDING),
        Expanded(
          child: Stack(
            children: [
              GoogleMap(
                myLocationEnabled: true,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: location.location ??
                      const LatLng(
                        27.68834123522099,
                        85.3356108224248,
                      ),
                  zoom: 5,
                ),
                markers: route.markers,
                onMapCreated: (controller) {
                  _controller.complete(controller);
                  if (location.location != null) {
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: location.location!,
                          zoom: 12,
                        ),
                      ),
                    );
                  }
                },
              ),
              // Positioned(
              //   bottom: BASE_PADDING,
              //   left: BASE_PADDING,
              //   right: BASE_PADDING,
              //   child: Center(
              //     child: GeneralButton(
              //       color: Colors.green,
              //       child: Text(
              //         ' VIEW ALL ROUTES ',
              //         style: TextStyle(
              //           color: TEXT_WHITE,
              //           fontWeight: FontWeight.bold,
              //           fontSize: DETAILS_TEXT - 2,
              //         ),
              //       ),
              //       onTab: () {
              //         showModalBottomSheet(
              //           context: context,
              //           builder: (_) => RouteOrderDetailModal(),
              //           isScrollControlled: true,
              //           backgroundColor: TEXT_WHITE,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.vertical(
              //               top: Radius.circular(RADIUS),
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }
}
