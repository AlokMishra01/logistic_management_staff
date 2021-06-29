import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistic_management_staff/constants/colors.dart';
import 'package:logistic_management_staff/constants/values.dart';
import 'package:logistic_management_staff/widgets/header.dart';
import '../widgets/load_list_item.dart';
import '../widgets/load_header.dart';

class Load extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: BASE_PADDING),
        Header(
          title: 'Load',
          trailing: Padding(
            padding: const EdgeInsets.symmetric(horizontal: BASE_PADDING),
            child: CircleAvatar(
              backgroundColor: FIELD_BACKGROUND,
              child: IconButton(
                icon: Icon(CupertinoIcons.plus),
                color: BUTTON_BLUE,
                onPressed: () {},
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: BASE_PADDING),
          padding: const EdgeInsets.all(BASE_PADDING),
          decoration: BoxDecoration(
            color: BUTTON_BLUE,
            borderRadius: BorderRadius.circular(RADIUS),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoadHeader(
                title: "Capacity",
                value: "500 Kg",
              ),
              LoadHeader(
                title: "Occupied",
                value: "100 Kg.",
              ),
              LoadHeader(
                title: "Item Count",
                value: "50",
              ),
            ],
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
                  LoadListItem(),
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
