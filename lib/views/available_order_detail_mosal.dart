import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:logistic_management_staff/constants/enums.dart';
import 'package:logistic_management_staff/controllers/delivery_controller.dart';
import 'package:logistic_management_staff/controllers/pickup_controller.dart';
import 'package:logistic_management_staff/models/assigned_response_model.dart';
import 'package:logistic_management_staff/models/pickup_response_model.dart';
import 'package:logistic_management_staff/widgets/custom_button.dart';
import 'package:logistic_management_staff/widgets/custom_button_outline.dart';
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

class AvailableOrderDetailModal extends StatefulWidget {
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
  State<AvailableOrderDetailModal> createState() =>
      _AvailableOrderDetailModalState();
}

class _AvailableOrderDetailModalState extends State<AvailableOrderDetailModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
            const SizedBox(height: BASE_PADDING),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: TEXT_SECONDARY_LIGHT,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: BASE_PADDING),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                            const Icon(
                              CupertinoIcons.map,
                              color: TEXT_WHITE,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
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
                                    widget.isPickOff
                                        ? widget.pickup.senderLat ??
                                            '27.688250415756407'
                                        : widget.assign.senderLat ??
                                            '27.688250415756407',
                                  ),
                                  double.parse(
                                    widget.isPickOff
                                        ? widget.pickup.senderLon ??
                                            '85.33557353207128'
                                        : widget.assign.senderLon ??
                                            '85.33557353207128',
                                  ),
                                ),
                                latLngTo: LatLng(
                                  double.parse(
                                    widget.isPickOff
                                        ? widget.pickup.recieverLat ??
                                            '27.688250415756407'
                                        : widget.assign.recieverLat ??
                                            '27.688250415756407',
                                  ),
                                  double.parse(
                                    widget.isPickOff
                                        ? widget.pickup.recieverLon ??
                                            '85.33557353207128'
                                        : widget.assign.recieverLon ??
                                            '85.33557353207128',
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: BASE_PADDING),
                    const ProfileInfoHeading(title: 'Sender Inforamtion'),
                    DetailRow(
                      title: 'Name: ',
                      value: widget.isPickOff
                          ? '${widget.pickup.senderName}'
                          : '${widget.assign.senderName}',
                    ),
                    DetailRow(
                      title: 'Address: ',
                      value: widget.isPickOff
                          ? '${widget.pickup.senderAddress}'
                          : '${widget.assign.senderAddress}',
                    ),
                    DetailRow(
                      title: 'Mobile Number: ',
                      value: widget.isPickOff
                          ? '${widget.pickup.senderMobileno}'
                          : '${widget.assign.senderMobileno}',
                    ),
                    // DetailRow(
                    //   title: 'Email: ',
                    //   value: '',
                    // ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GeneralButton(
                            color: YELLOW,
                            child: const Text(
                              'SHOW ON MAP',
                              style: TextStyle(
                                color: TEXT_WHITE,
                                fontSize: DETAILS_TEXT - 2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTab: () {
                              widget.isPickOff
                                  ? launch(
                                      'https://www.google.com/maps/@'
                                      '${widget.pickup.senderLat},'
                                      '${widget.pickup.senderLon},15z',
                                    )
                                  : launch(
                                      'https://www.google.com/maps/@'
                                      '${widget.assign.senderLat},'
                                      '${widget.assign.senderLon},15z',
                                    );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (cxt) => MapPage(
                              //       latLngFrom: widget.isPickOff
                              //           ? LatLng(
                              //               double.parse(
                              //                   (widget.pickup.senderLat ??
                              //                           '0.0')
                              //                       .toString()),
                              //               double.parse(
                              //                   (widget.pickup.senderLon ??
                              //                           '0.0')
                              //                       .toString()),
                              //             )
                              //           : LatLng(
                              //               double.parse(
                              //                   (widget.assign.senderLat ??
                              //                           '0.0')
                              //                       .toString()),
                              //               double.parse(
                              //                   (widget.assign.senderLon ??
                              //                           '0.0')
                              //                       .toString()),
                              //             ),
                              //     ),
                              //   ),
                              // );
                            },
                          ),
                          const SizedBox(width: 8.0),
                          GeneralButton(
                            color: FIELD_BACKGROUND,
                            child: const Text(
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
                                '${widget.isPickOff ? widget.pickup.senderMobileno : widget.assign.senderMobileno}',
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: BASE_PADDING),
                    const ProfileInfoHeading(title: 'Reciever Inforamtion'),
                    DetailRow(
                      title: 'Name: ',
                      value: widget.isPickOff
                          ? '${widget.pickup.recieverName}'
                          : '${widget.assign.recieverName}',
                    ),
                    DetailRow(
                      title: 'Address: ',
                      value: widget.isPickOff
                          ? '${widget.pickup.recieverAddress}'
                          : '${widget.assign.recieverAddress}',
                    ),
                    DetailRow(
                      title: 'Mobile Number: ',
                      value: widget.isPickOff
                          ? '${widget.pickup.recieverMobileno}'
                          : '${widget.assign.recieverMobileno}',
                    ),
                    // DetailRow(title: 'Email: ', value: ''),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GeneralButton(
                            color: YELLOW,
                            child: const Text(
                              'SHOW ON MAP',
                              style: TextStyle(
                                color: TEXT_WHITE,
                                fontSize: DETAILS_TEXT - 2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTab: () {
                              widget.isPickOff
                                  ? launch(
                                      'https://www.google.com/maps/@'
                                      '${widget.pickup.recieverLat},'
                                      '${widget.pickup.recieverLon},15z',
                                    )
                                  : launch(
                                      'https://www.google.com/maps/@'
                                      '${widget.assign.recieverLat},'
                                      '${widget.assign.recieverLon},15z',
                                    );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (cxt) => MapPage(
                              //
                              //       latLngFrom: widget.isPickOff
                              //           ? LatLng(
                              //               double.parse(
                              //                   (widget.pickup.recieverLat ??
                              //                           '0.0')
                              //                       .toString()),
                              //               double.parse(
                              //                   (widget.pickup.recieverLon ??
                              //                           '0.0')
                              //                       .toString()),
                              //             )
                              //           : LatLng(
                              //               double.parse(
                              //                   (widget.assign.recieverLat ??
                              //                           '0.0')
                              //                       .toString()),
                              //               double.parse(
                              //                   (widget.assign.recieverLon ??
                              //                           '0.0')
                              //                       .toString()),
                              //             ),
                              //     ),
                              //   ),
                              // );
                            },
                          ),
                          const SizedBox(width: 8.0),
                          GeneralButton(
                            color: FIELD_BACKGROUND,
                            child: const Text(
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
                                '${widget.isPickOff ? widget.pickup.recieverMobileno : widget.assign.recieverMobileno}',
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: BASE_PADDING),
                    const ProfileInfoHeading(
                        title: 'Delivery / Pickup Inforamtion'),
                    widget.isPickOff
                        ? const DetailRow(
                            title: 'Pickup Date: ',
                            value: 'N/a',
                            // value: '${pickup.pickupDate}',
                          )
                        : Container(),
                    widget.isPickOff
                        ? DetailRow(
                            title: 'Pickup Time: ',
                            value: Jiffy(widget.pickup.pickupTime, "H:m:s").jm,
                          )
                        : Container(),
                    // !isPickOff
                    //     ? DetailRow(
                    //         title: 'Delivery Date: ',
                    //         value: '${assign. ?? ''}',
                    //       )
                    //     : Container(),
                    !widget.isPickOff
                        ? DetailRow(
                            title: 'Delivery Time: ',
                            value: '${widget.assign.dropoffTime}',
                          )
                        : Container(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GeneralButton(
                        color: BUTTON_BLUE,
                        child: Text(
                          widget.pickup.id != null
                              ? 'Pick Up'
                              : widget.assign.status == 'Completed'
                                  ? 'Delivered'
                                  : 'Deliver',
                          // 'DELIVERED / PICKED UP',
                          style: const TextStyle(
                            color: TEXT_WHITE,
                            fontSize: DETAILS_TEXT - 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTab: () {
                          widget.pickup.id != null
                              ? _pickup(context)
                              : _dropOff();
                        },
                      ),
                    ),
                    const SizedBox(height: BASE_PADDING),
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
          packageID: widget.pickup.id ?? 0,
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

  _dropOff() async {
    if (widget.assign.status == 'Completed') {
      return;
    }

    // Navigator.pop(context);

    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
      maxHeight: 1080,
      maxWidth: 1080,
    );

    if (photo == null) {
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: TEXT_WHITE,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(RADIUS),
        ),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(RADIUS),
              child: Image.file(
                File(photo.path),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: SizedBox(
                    height: 48.0,
                    child: CustomButtonOutline(
                      title: 'Cancel',
                      color: Colors.redAccent,
                      onTab: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: SizedBox(
                    height: 48.0,
                    child: CustomButton(
                      title: 'Okay',
                      onTab: () {
                        Navigator.pop(context);
                        _save(context: context, imagePath: photo.path);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  _save({required BuildContext context, required String imagePath}) async {
    final progressDialog = getProgressDialog(context: context);
    progressDialog.show(useSafeArea: false);

    bool b = await context.read<DeliveryController>().deliverPackage(
          packageID: widget.assign.id ?? 0,
          dispatchID: widget.assign.dispatchId ?? 0,
          imagePath: imagePath,
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
