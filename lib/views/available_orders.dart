import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/route_detail.dart';
import '../views/search_page.dart';
import '../constants/colors.dart';
import '../constants/values.dart';
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
                    MaterialPageRoute(builder: (cxt) => SearchPage()),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
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
                  OrderListItem(isactive: 2 != i),
                  if (i == 2) SizedBox(height: HEADER_TEXT * 2),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
