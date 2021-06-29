import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/values.dart';
import '../../widgets/detail_row.dart';
import '../views/load_detail_model.dart';

class LoadListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: BASE_PADDING),
      padding: EdgeInsets.symmetric(horizontal: BASE_PADDING / 1.25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RADIUS),
        color: FIELD_BACKGROUND,
      ),
      child: Column(
        children: [
          SizedBox(height: BASE_PADDING / 1.25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailRow(
                    title: "Size: ",
                    value: "10 x 10 ft",
                  ),
                  DetailRow(
                    title: "Customer Name: ",
                    value: "Birendra Thapa",
                  ),
                  DetailRow(
                    title: "Address: ",
                    value: "Bhaktapur",
                  ),
                  DetailRow(
                    title: "Contact: ",
                    value: "+977 - 9878989898",
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor: RED,
                child: IconButton(
                  icon: Icon(
                    CupertinoIcons.clear_thick,
                    color: TEXT_WHITE,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.map),
                    color: TEXT_BLUE,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: (context),
                    builder: (_) => LoadDetailModal(),
                    isScrollControlled: false,
                    backgroundColor: TEXT_WHITE,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(RADIUS),
                      ),
                    ),
                  );
                },
                icon: Icon(CupertinoIcons.ellipsis),
                color: TEXT_BLUE,
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Text(
                  "15 Kg.",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: DETAILS_TEXT,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
