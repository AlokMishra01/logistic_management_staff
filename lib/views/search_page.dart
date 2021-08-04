import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistic_management_staff/models/dispatch_model.dart';
import 'package:logistic_management_staff/models/request_model.dart';
import 'package:logistic_management_staff/providers/delivery_provider.dart';
import 'package:logistic_management_staff/providers/pickup_provider.dart';
import 'package:logistic_management_staff/widgets/order_list_item.dart';
import 'package:provider/provider.dart';

import '../constants/values.dart';
import '../widgets/custom_input.dart';
import '../widgets/header.dart';

class SearchPage extends StatefulWidget {
  final bool isPickOff;

  const SearchPage({
    Key? key,
    this.isPickOff = true,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pickUp = context.watch<PickUpProvider>();
    final delivery = context.watch<DeliveryProvider>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(title: 'Search', backButton: true),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: BASE_PADDING),
              child: CustomInput(
                controller: _search,
                hint: 'Search order here...',
                icon: CupertinoIcons.search,
              ),
            ),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: widget.isPickOff
                    ? pickUp.requests.length
                    : delivery.dispatches.length,
                separatorBuilder: (_, i) => SizedBox(height: BASE_PADDING),
                itemBuilder: (_, i) {
                  final r =
                      widget.isPickOff ? pickUp.requests[i] : RequestModel();
                  final d = widget.isPickOff
                      ? DispatchModel()
                      : delivery.dispatches[i];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (i == 0) SizedBox(height: HEADER_TEXT / 2),
                      OrderListItem(
                        request: r,
                        dispatch: d,
                        isPickOff: widget.isPickOff,
                      ),
                      if (i == pickUp.requests.length - 1)
                        SizedBox(height: HEADER_TEXT * 2),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
