import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/values.dart';
import '../widgets/header.dart';
import '../widgets/order_list_item.dart';

class RouteDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(title: 'Route Detail', backButton: true),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (_, i) => SizedBox(height: BASE_PADDING),
                itemBuilder: (_, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (i == 0)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: BASE_PADDING,
                              vertical: BASE_PADDING / 2,
                            ),
                            child: Text(
                              "Ratnapark, Bagmati, Nepal",
                              style: TextStyle(
                                color: TEXT_SECONDARY_LIGHT,
                                fontSize: DETAILS_TEXT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      OrderListItem(isactive: 2 != i),
                      if (i == 2) SizedBox(height: HEADER_TEXT * 2),
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
