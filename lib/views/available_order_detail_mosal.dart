import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logistic_management_staff/constants/enums.dart';
import 'package:logistic_management_staff/controllers/delivery_controller.dart';
import 'package:logistic_management_staff/controllers/pickup_controller.dart';
import 'package:logistic_management_staff/models/assigned_response_model.dart';
import 'package:logistic_management_staff/models/pickup_response_model.dart';
import 'package:logistic_management_staff/widgets/dialogs/bottom_dialog.dart';
import 'package:logistic_management_staff/widgets/dialogs/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.dart';
import '../../constants/values.dart';
import '../../widgets/detail_row.dart';
import '../../widgets/general_button.dart';
import '../../widgets/profile_info_heading.dart';
import 'map_view.dart';

class AvailableOrderDetailModal extends StatelessWidget {
  final bool isPickOff;
  final PickupDataModel pickup;
  final AssignedModel assign;

  const AvailableOrderDetailModal({
    Key? key,
    required this.pickup,
    required this.assign,
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
                                        ? pickup.senderLat ??
                                            '27.688250415756407'
                                        : assign.senderLat ??
                                            '27.688250415756407',
                                  ),
                                  double.parse(
                                    isPickOff
                                        ? pickup.senderLon ??
                                            '85.33557353207128'
                                        : assign.senderLon ??
                                            '85.33557353207128',
                                  ),
                                ),
                                latLngTo: LatLng(
                                  double.parse(
                                    isPickOff
                                        ? pickup.recieverLat ??
                                            '27.688250415756407'
                                        : assign.recieverLat ??
                                            '27.688250415756407',
                                  ),
                                  double.parse(
                                    isPickOff
                                        ? pickup.recieverLon ??
                                            '85.33557353207128'
                                        : assign.recieverLon ??
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
                          ? '${pickup.senderName}'
                          : '${assign.senderName}',
                    ),
                    DetailRow(
                      title: 'Address: ',
                      value: isPickOff
                          ? '${pickup.senderAddress}'
                          : '${assign.senderAddress}',
                    ),
                    DetailRow(
                      title: 'Mobile Number: ',
                      value: isPickOff
                          ? '${pickup.senderMobileno}'
                          : '${assign.senderMobileno}',
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
                            '${isPickOff ? pickup.senderMobileno : assign.senderMobileno}',
                          );
                        },
                      ),
                    ),
                    SizedBox(height: BASE_PADDING),
                    ProfileInfoHeading(title: 'Reciever Inforamtion'),
                    DetailRow(
                      title: 'Name: ',
                      value: isPickOff
                          ? '${pickup.recieverName}'
                          : '${assign.recieverName}',
                    ),
                    DetailRow(
                      title: 'Address: ',
                      value: isPickOff
                          ? '${pickup.recieverAddress}'
                          : '${assign.recieverAddress}',
                    ),
                    DetailRow(
                      title: 'Mobile Number: ',
                      value: isPickOff
                          ? '${pickup.recieverMobileno}'
                          : '${assign.recieverMobileno}',
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
                            '${isPickOff ? pickup.recieverMobileno : assign.recieverMobileno}',
                          );
                        },
                      ),
                    ),
                    SizedBox(height: BASE_PADDING),
                    ProfileInfoHeading(title: 'Delivery / Pickup Inforamtion'),
                    isPickOff
                        ? DetailRow(
                            title: 'Pickup Date: ',
                            value: 'N/a',
                            // value: '${pickup.pickupDate}',
                          )
                        : Container(),
                    isPickOff
                        ? DetailRow(
                            title: 'Pickup Time: ',
                            value: '${pickup.pickupTime}',
                          )
                        : Container(),
                    // !isPickOff
                    //     ? DetailRow(
                    //         title: 'Delivery Date: ',
                    //         value: '${assign. ?? ''}',
                    //       )
                    //     : Container(),
                    !isPickOff
                        ? DetailRow(
                            title: 'Delivery Time: ',
                            value: '${assign.dropoffTime}',
                          )
                        : Container(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GeneralButton(
                        color: BUTTON_BLUE,
                        child: Text(
                          pickup.id != null
                              ? 'Pick Up'
                              : assign.status == 'Completed'
                                  ? '${assign.status}'
                                  : 'Deliver',
                          // 'DELIVERED / PICKED UP',
                          style: TextStyle(
                            color: TEXT_WHITE,
                            fontSize: DETAILS_TEXT - 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTab: () {
                          pickup.id != null
                              ? _pickup(context)
                              : _dropOff(context);
                        },
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

  _pickup(BuildContext context) async {
    final progressDialog = getProgressDialog(context: context);
    progressDialog.show(useSafeArea: false);

    bool b = await context.read<PickupController>().pickupPackage(
          packageID: pickup.id ?? 0,
        );

    progressDialog.dismiss();

    if (b) {
      showBottomDialog(
        context: context,
        dialogType: DialogType.SUCCESS,
        title: 'Success',
        message: 'You have successfully picked up package.',
      );
      Navigator.pop(context);
    } else {
      showBottomDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: 'Error',
        message: 'Oops! Some thing went wrong. Please try again.',
      );
    }
  }

  _dropOff(BuildContext context) async {
    if (assign.status == 'Completed') {
      return;
    }

    final progressDialog = getProgressDialog(context: context);
    progressDialog.show(useSafeArea: false);

    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (photo == null) {
      progressDialog.dismiss();
      return;
    }

    bool b = await context.read<DeliveryController>().deliverPackage(
          packageID: assign.id ?? 0,
          dispatchID: assign.dispatchId ?? 0,
          imagePath: photo.path,
        );

    progressDialog.dismiss();

    if (b) {
      showBottomDialog(
        context: context,
        dialogType: DialogType.SUCCESS,
        title: 'Success',
        message: 'You have successfully delivered package.',
      );
      Navigator.pop(context);
    } else {
      showBottomDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: 'Error',
        message: 'Oops! Some thing went wrong. Please try again.',
      );
    }
  }
}
