import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistic_management_staff/models/assigned_response_model.dart';
import 'package:logistic_management_staff/models/pickup_response_model.dart';
import 'package:logistic_management_staff/widgets/order_list_item.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/values.dart';
import '../controllers/delivery_controller.dart';
import '../controllers/pickup_controller.dart';
import '../views/search_page.dart';
import '../widgets/header.dart';
import '../widgets/order_type_bar.dart';

class AvailableOrders extends StatefulWidget {
  const AvailableOrders({Key? key}) : super(key: key);

  @override
  _AvailableOrdersState createState() => _AvailableOrdersState();
}

class _AvailableOrdersState extends State<AvailableOrders> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final pickup = context.watch<PickupController>();
    final delivery = context.watch<DeliveryController>();
    return Column(
      children: [
        const SizedBox(height: BASE_PADDING),
        Header(
          title: 'Available Order',
          trailing: Padding(
            padding: const EdgeInsets.symmetric(horizontal: BASE_PADDING),
            child: CircleAvatar(
              backgroundColor: FIELD_BACKGROUND,
              child: IconButton(
                icon: const Icon(CupertinoIcons.search),
                color: BUTTON_BLUE,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (cxt) => SearchPage(
                        isPickOff: _selected == 0,
                      ),
                    ),
                    // MaterialPageRoute(builder: (cxt) => RouteDetail()),
                  );
                },
              ),
            ),
          ),
        ),
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
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 60.0),
              itemCount: _selected == 0
                  ? pickup.pendingPickups.length
                  : delivery.assignedList.length,
              // : delivery.dispatches.length,
              separatorBuilder: (_, i) => const SizedBox(height: BASE_PADDING),
              itemBuilder: (_, i) {
                PickupDataModel p = _selected == 0
                    ? pickup.pendingPickups[i]
                    : PickupDataModel();
                AssignedModel a =
                    _selected == 0 ? AssignedModel() : delivery.assignedList[i];
                // final d =
                //     _selected == 0 ? DispatchModel() : delivery.dispatches[i];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OrderListItem(
                      pickup: p,
                      assign: a,
                      isPickOff: _selected == 0,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
