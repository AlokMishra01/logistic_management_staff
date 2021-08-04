import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logistic_management_staff/models/dispatch_model.dart';
import 'package:logistic_management_staff/models/request_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.dart';
import '../../constants/values.dart';
import '../../widgets/detail_row.dart';
import '../../widgets/general_button.dart';
import '../../widgets/profile_info_heading.dart';
import 'map_view.dart';

class AvailableOrderDetailModal extends StatelessWidget {
  final bool isPickOff;
  final RequestModel request;
  final DispatchModel dispatch;

  const AvailableOrderDetailModal({
    Key? key,
    required this.request,
    required this.dispatch,
    this.isPickOff = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                                    isPickOff
                                        ? request.senderLat ??
                                            '27.688250415756407'
                                        : dispatch.senderLat ??
                                            '27.688250415756407',
                                  ),
                                  double.parse(
                                    isPickOff
                                        ? request.senderLon ??
                                            '85.33557353207128'
                                        : dispatch.senderLon ??
                                            '85.33557353207128',
                                  ),
                                ),
                                latLngTo: LatLng(
                                  double.parse(
                                    isPickOff
                                        ? request.recieverLat ??
                                            '27.688250415756407'
                                        : dispatch.recieverLat ??
                                            '27.688250415756407',
                                  ),
                                  double.parse(
                                    isPickOff
                                        ? request.recieverLon ??
                                            '85.33557353207128'
                                        : dispatch.recieverLon ??
                                            '85.33557353207128',
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
                      value: isPickOff
                          ? '${request.senderName}'
                          : '${dispatch.senderName}',
                    ),
                    DetailRow(
                      title: 'Address: ',
                      value: isPickOff
                          ? '${request.senderAddress}'
                          : '${dispatch.senderAddress}',
                    ),
                    DetailRow(
                      title: 'Mobile Number: ',
                      value: isPickOff
                          ? '${request.senderMobileno}'
                          : '${dispatch.senderMobileno}',
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
                              'tel: ${isPickOff ? request.senderMobileno : dispatch.senderMobileno}');
                        },
                      ),
                    ),
                    SizedBox(height: BASE_PADDING),
                    ProfileInfoHeading(title: 'Reciever Inforamtion'),
                    DetailRow(
                      title: 'Name: ',
                      value: isPickOff
                          ? '${request.recieverName}'
                          : '${dispatch.recieverName}',
                    ),
                    DetailRow(
                      title: 'Address: ',
                      value: isPickOff
                          ? '${request.recieverAddress}'
                          : '${dispatch.recieverAddress}',
                    ),
                    DetailRow(
                      title: 'Mobile Number: ',
                      value: isPickOff
                          ? '${request.recieverMobileno}'
                          : '${dispatch.recieverMobileno}',
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
                              'tel: ${isPickOff ? request.recieverMobileno : dispatch.recieverMobileno}');
                        },
                      ),
                    ),
                    SizedBox(height: BASE_PADDING),
                    ProfileInfoHeading(title: 'Delivery / Pickup Inforamtion'),
                    isPickOff
                        ? DetailRow(
                            title: 'Pickup Date: ',
                            value: '${request.pickupDate}',
                          )
                        : Container(),
                    isPickOff
                        ? DetailRow(
                            title: 'Pickup Time: ',
                            value: '${request.pickupTime}',
                          )
                        : Container(),
                    !isPickOff
                        ? DetailRow(
                            title: 'Delivery Date: ',
                            value: '${dispatch.dropoffDate}',
                          )
                        : Container(),
                    !isPickOff
                        ? DetailRow(
                            title: 'Delivery Time: ',
                            value: '${dispatch.dropoffTime}',
                          )
                        : Container(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GeneralButton(
                        color: BUTTON_BLUE,
                        child: Text(
                          'DELIVERED / PICKED UP',
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
