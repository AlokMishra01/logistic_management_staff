import 'package:flutter/material.dart';
import 'package:logistic_management_staff/constants/colors.dart';
import 'package:logistic_management_staff/constants/values.dart';
import 'package:logistic_management_staff/controllers/delivery_controller.dart';
import 'package:logistic_management_staff/widgets/header.dart';
import 'package:provider/provider.dart';

import '../widgets/load_list_item.dart';
import 'search_page.dart';

class Load extends StatelessWidget {
  const Load({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final delivery = context.watch<DeliveryController>();
    return Column(
      children: [
        Header(
          title: 'Load',
          trailing: Padding(
            padding: const EdgeInsets.symmetric(horizontal: BASE_PADDING),
            child: IconButton(
              icon: const Icon(Icons.search_rounded),
              color: BUTTON_BLUE,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SearchPage(),
                  ),
                );
              },
            ),
          ),
        ),
        // Container(
        //   margin: const EdgeInsets.symmetric(horizontal: BASE_PADDING),
        //   padding: const EdgeInsets.all(BASE_PADDING),
        //   decoration: BoxDecoration(
        //     color: BUTTON_BLUE,
        //     borderRadius: BorderRadius.circular(RADIUS),
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       LoadHeader(
        //         title: "Capacity",
        //         value: "500 Kg",
        //       ),
        //       LoadHeader(
        //         title: "Occupied",
        //         value: "100 Kg.",
        //       ),
        //       LoadHeader(
        //         title: "Item Count",
        //         value: "50",
        //       ),
        //     ],
        //   ),
        // ),
        if (delivery.dispatchedList.isNotEmpty)
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => delivery.getDispatched(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: double.infinity),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: BASE_PADDING,
                        vertical: BASE_PADDING / 2,
                      ),
                      child: Text(
                        'Today',
                        style: TextStyle(
                          fontSize: TITLE_TEXT,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                    ),
                    for (var p in delivery.dispatchPickupList)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LoadListItem(
                            model: p,
                            isDispatch: false,
                          ),
                          const SizedBox(height: BASE_PADDING)
                        ],
                      ),
                    for (var d in delivery.dispatchedList)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LoadListItem(
                            model: d,
                          ),
                          const SizedBox(height: BASE_PADDING)
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        if (delivery.dispatchedList.isEmpty)
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(BASE_PADDING * 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'No loads for today right now.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: TEXT_SECONDARY,
                        fontSize: SUB_HEADER_TEXT,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => delivery.getDispatched(),
                      icon: const Icon(Icons.refresh_rounded),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
