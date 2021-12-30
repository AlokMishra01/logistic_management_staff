import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logistic_management_staff/models/assigned_response_model.dart';
import 'package:logistic_management_staff/widgets/detail_row.dart';
import 'package:logistic_management_staff/widgets/general_button.dart';
import 'package:logistic_management_staff/widgets/profile_info_heading.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/colors.dart';
import '../constants/values.dart';
import '../controllers/delivery_controller.dart';
import '../widgets/header.dart';
import 'map_view.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final delivery = context.watch<DeliveryController>();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: BASE_PADDING),
          const Header(
            title: 'History',
            backButton: true,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => delivery.getDelivered(),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 60.0),
                itemCount: delivery.deliveredList.length,
                // : delivery.dispatches.length,
                separatorBuilder: (_, i) =>
                    const SizedBox(height: BASE_PADDING),
                itemBuilder: (_, i) {
                  final item = delivery.deliveredList[i];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: BASE_PADDING,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: BASE_PADDING / 1.25,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(RADIUS),
                              color: GREEN,
                              // color: (isactive) ? GREEN : BLUE_BACKGROUND,
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: BASE_PADDING / 1.25),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DetailRow(
                                          title: "Time",
                                          value: "${item.dropoffTime}",
                                        ),
                                        Text(
                                          '',
                                          style: TextStyle(
                                            fontSize: DETAILS_TEXT + 2,
                                            color: TEXT_SECONDARY,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5,
                                          ),
                                        ),
                                        DetailRow(
                                          title: "Customer Name",
                                          value: "${item.recieverName}",
                                        ),
                                        DetailRow(
                                          title: "Address",
                                          value: "${item.recieverAddress}",
                                        ),
                                        DetailRow(
                                          title: "Contact",
                                          value: "${item.recieverMobileno}",
                                        ),
                                      ],
                                    ),
                                    CircleAvatar(
                                      backgroundColor: TEXT_BLUE,
                                      child: IconButton(
                                        icon: Icon(
                                          CupertinoIcons.phone_fill,
                                          color: TEXT_WHITE,
                                        ),
                                        onPressed: () {
                                          launch(
                                              'tel: ${item.recieverMobileno}');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 1,
                                      child: Text(
                                        "${item.packageWeight} Kg.",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: DETAILS_TEXT,
                                          fontWeight: FontWeight.w500,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: (context),
                                          builder: (_) => _modalContent(
                                            context,
                                            item,
                                          ),
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
                                        'NRs. ${item.packagePrice ?? 0.0}',
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
                          ),
                          // if (!isactive)
                          // Positioned(
                          //   top: 0,
                          //   bottom: 0,
                          //   left: 0,
                          //   right: 0,
                          //   child: Material(
                          //     borderRadius: BorderRadius.circular(RADIUS),
                          //     color: TEXT_WHITE.withOpacity(0.5),
                          //   ),
                          // ),
                          // if (!isactive)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: (context),
                                  builder: (_) => _modalContent(context, item),
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
                              color: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _modalContent(BuildContext context, AssignedModel item) {
    return Container(
      decoration: BoxDecoration(
        color: TEXT_WHITE,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(RADIUS),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: BASE_PADDING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: BASE_PADDING),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 4,
                  decoration: BoxDecoration(
                    color: TEXT_SECONDARY_LIGHT,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: BASE_PADDING),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: GeneralButton(
                        color: Colors.green,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.map,
                              color: TEXT_WHITE,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'View Route',
                              style: TextStyle(
                                color: TEXT_WHITE,
                                fontSize: DETAILS_TEXT - 2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        onTab: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MapPage(
                                latLngFrom: LatLng(
                                  double.parse(
                                    item.senderLat ?? '27.688250415756407',
                                  ),
                                  double.parse(
                                    item.senderLon ?? '85.33557353207128',
                                  ),
                                ),
                                latLngTo: LatLng(
                                  double.parse(
                                    item.recieverLat ?? '27.688250415756407',
                                  ),
                                  double.parse(
                                    item.recieverLon ?? '85.33557353207128',
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: BASE_PADDING),
                    ProfileInfoHeading(title: 'Sender Inforamtion'),
                    DetailRow(
                      title: 'Name: ',
                      value: '${item.senderName}',
                    ),
                    DetailRow(
                      title: 'Address: ',
                      value: '${item.senderAddress}',
                    ),
                    DetailRow(
                      title: 'Mobile Number: ',
                      value: '${item.senderMobileno}',
                    ),
                    DetailRow(
                      title: 'Email: ',
                      value: '',
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GeneralButton(
                        color: FIELD_BACKGROUND,
                        child: Text(
                          'CALL SENDER',
                          style: TextStyle(
                            color: TEXT_BLUE,
                            fontSize: DETAILS_TEXT - 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTab: () {
                          launch(
                            'tel: '
                            '${item.senderMobileno}',
                          );
                        },
                      ),
                    ),
                    SizedBox(height: BASE_PADDING),
                    ProfileInfoHeading(title: 'Reciever Inforamtion'),
                    DetailRow(
                      title: 'Name: ',
                      value: '${item.recieverName}',
                    ),
                    DetailRow(
                      title: 'Address: ',
                      value: '${item.recieverAddress}',
                    ),
                    DetailRow(
                      title: 'Mobile Number: ',
                      value: '${item.recieverMobileno}',
                    ),
                    DetailRow(title: 'Email: ', value: ''),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GeneralButton(
                        color: FIELD_BACKGROUND,
                        child: Text(
                          'CALL RECIVER',
                          style: TextStyle(
                            color: TEXT_BLUE,
                            fontSize: DETAILS_TEXT - 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTab: () {
                          launch(
                            'tel: '
                            '${item.recieverMobileno}',
                          );
                        },
                      ),
                    ),
                    SizedBox(height: BASE_PADDING),
                    ProfileInfoHeading(title: 'Delivery / Pickup Inforamtion'),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GeneralButton(
                        color: BUTTON_BLUE,
                        child: Text(
                          '${item.status}',
                          // 'DELIVERED / PICKED UP',
                          style: TextStyle(
                            color: TEXT_WHITE,
                            fontSize: DETAILS_TEXT - 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTab: () {},
                      ),
                    ),
                    SizedBox(height: BASE_PADDING),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
