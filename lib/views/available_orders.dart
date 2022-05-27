import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logistic_management_staff/controllers/geo_locator_controller.dart';
import 'package:logistic_management_staff/models/assigned_response_model.dart';
import 'package:logistic_management_staff/models/pickup_response_model.dart';
import 'package:logistic_management_staff/widgets/order_list_item.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/values.dart';
import '../controllers/delivery_controller.dart';
import '../controllers/pickup_controller.dart';
import '../widgets/header.dart';
import '../widgets/order_type_bar.dart';
import 'all_notification.dart';

class AvailableOrders extends StatefulWidget {
  const AvailableOrders({Key? key}) : super(key: key);

  @override
  _AvailableOrdersState createState() => _AvailableOrdersState();
}

class _AvailableOrdersState extends State<AvailableOrders> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final location = context.watch<GeoLocatorController>();
    final pickup = context.watch<PickupController>();
    final delivery = context.watch<DeliveryController>();

    final Marker marker = Marker(
      markerId: const MarkerId('myLoc'),
      position: location.location ??
          const LatLng(27.68834123522099, 85.3356108224248),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: BASE_PADDING),
        Header(
          title: 'Available Order',
          trailing: Padding(
            padding: const EdgeInsets.symmetric(horizontal: BASE_PADDING),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_rounded,
              ),
              color: BUTTON_BLUE,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AllNotification()),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: BASE_PADDING,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "My Location",
                style: TextStyle(
                  color: TEXT_BLUE,
                  fontSize: TITLE_TEXT,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // TextButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (_) => const AllPackages()),
              //     );
              //   },
              //   child: Text(
              //     'View All',
              //     style: GoogleFonts.comfortaa(
              //       color: colors.TEXT_BLUE,
              //       fontSize: values.DETAILS_TEXT,
              //     ),
              //   ),
              //   style: TextButton.styleFrom(
              //     backgroundColor: colors.FIELD_BACKGROUND,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(values.RADIUS),
              //     ),
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 12.0,
              //       vertical: 4.0,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BASE_PADDING),
          child: SizedBox(
            height: (size.width - (BASE_PADDING * 2)) / 2,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(RADIUS),
              child: GoogleMap(
                myLocationEnabled: true,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                zoomGesturesEnabled: false,
                zoomControlsEnabled: false,
                scrollGesturesEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: location.location ??
                      const LatLng(27.68834123522099, 85.3356108224248),
                  zoom: 5,
                ),
                markers: {marker},
                onMapCreated: (controller) {
                  if (location.location != null) {
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: location.location!,
                          zoom: 18,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: BASE_PADDING),
        Padding(
          padding: const EdgeInsets.all(BASE_PADDING),
          child: Container(
            decoration: BoxDecoration(
              color: FIELD_BACKGROUND,
              borderRadius: BorderRadius.circular(RADIUS),
            ),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                OrderTypeBar(
                  title: "PICK UP",
                  selected: _selected == 0,
                  onTab: () {
                    _selected = 0;
                    setState(() {});
                  },
                ),
                OrderTypeBar(
                  title: "DROP OFF",
                  selected: _selected == 1,
                  onTab: () {
                    _selected = 1;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => _selected == 0
                ? pickup.getPendingPickups()
                : delivery.getAssigned(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (_selected == 0)
                    for (var p in pickup.pendingPickups)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          OrderListItem(
                            pickup: p,
                            assign: AssignedModel(),
                            isPickOff: _selected == 0,
                          ),
                          const SizedBox(height: BASE_PADDING),
                        ],
                      ),
                  if (_selected == 0 && pickup.pendingPickups.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(BASE_PADDING * 2),
                      child: Text(
                        'No pick ups right now.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: TEXT_SECONDARY,
                          fontSize: SUB_HEADER_TEXT,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (_selected == 1)
                    for (var a in delivery.assignedList)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          OrderListItem(
                            pickup: PickupDataModel(),
                            assign: a,
                            isPickOff: _selected == 0,
                          ),
                          const SizedBox(height: BASE_PADDING),
                        ],
                      ),
                  if (_selected == 1 && delivery.assignedList.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(BASE_PADDING * 2),
                      child: Text(
                        'No deliveries right now.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: TEXT_SECONDARY,
                          fontSize: SUB_HEADER_TEXT,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        // ListView.separated(
        //   physics: const NeverScrollableScrollPhysics(),
        //   padding: const EdgeInsets.only(bottom: 60.0),
        //   itemCount: _selected == 0
        //       ? pickup.pendingPickups.length
        //       : delivery.assignedList.length,
        //   // : delivery.dispatches.length,
        //   separatorBuilder: (_, i) => const SizedBox(height: BASE_PADDING),
        //   itemBuilder: (_, i) {
        //     PickupDataModel p = _selected == 0
        //         ? pickup.pendingPickups[i]
        //         : PickupDataModel();
        //     AssignedModel a =
        //         _selected == 0 ? AssignedModel() : delivery.assignedList[i];
        //     // final d =
        //     //     _selected == 0 ? DispatchModel() : delivery.dispatches[i];
        //     return OrderListItem(
        //       pickup: p,
        //       assign: a,
        //       isPickOff: _selected == 0,
        //     );
        //   },
        // ),
      ],
    );
  }
}
