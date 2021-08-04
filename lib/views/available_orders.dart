import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistic_management_staff/models/dispatch_model.dart';
import 'package:logistic_management_staff/models/request_model.dart';
import 'package:logistic_management_staff/providers/authentication.dart';
import 'package:logistic_management_staff/providers/delivery_provider.dart';
import 'package:logistic_management_staff/providers/pickup_provider.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/values.dart';
import '../views/search_page.dart';
import '../widgets/header.dart';
import '../widgets/order_list_item.dart';
import '../widgets/order_type_bar.dart';

class AvailableOrders extends StatefulWidget {
  @override
  _AvailableOrdersState createState() => _AvailableOrdersState();
}

class _AvailableOrdersState extends State<AvailableOrders> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final pickUp = context.watch<PickUpProvider>();
    final delivery = context.watch<DeliveryProvider>();
    return Column(
      children: [
        SizedBox(height: BASE_PADDING),
        Header(
          title: 'Availabel Order',
          trailing: Padding(
            padding: const EdgeInsets.symmetric(horizontal: BASE_PADDING),
            child: CircleAvatar(
              backgroundColor: FIELD_BACKGROUND,
              child: IconButton(
                icon: Icon(CupertinoIcons.search),
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
                ? context.read<PickUpProvider>().fetchPickUp(
                      userId:
                          context.read<AuthenticationProvider>().staff!.id ?? 1,
                    )
                : context.read<DeliveryProvider>().fetchDispatched(
                      userId:
                          context.read<AuthenticationProvider>().staff!.id ?? 1,
                    ),
            child: ListView.separated(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: _selected == 0
                  ? pickUp.requests.length
                  : delivery.dispatches.length,
              separatorBuilder: (_, i) => SizedBox(height: BASE_PADDING),
              itemBuilder: (_, i) {
                final r = _selected == 0 ? pickUp.requests[i] : RequestModel();
                final d =
                    _selected == 0 ? DispatchModel() : delivery.dispatches[i];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // if (i == 0)
                    //   Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: BASE_PADDING,
                    //       vertical: BASE_PADDING / 2,
                    //     ),
                    //     child: Text(
                    //       'Today',
                    //       style: TextStyle(
                    //         fontSize: TITLE_TEXT,
                    //         fontWeight: FontWeight.w600,
                    //         height: 1,
                    //       ),
                    //     ),
                    //   ),
                    OrderListItem(
                      request: r,
                      dispatch: d,
                      isPickOff: _selected == 0,
                    ),
                    if (i == pickUp.requests.length - 1)
                      SizedBox(height: HEADER_TEXT * 2),
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
