import 'package:flutter/material.dart';
import 'package:logistic_management_staff/models/assigned_response_model.dart';
import 'package:logistic_management_staff/views/printer_connection.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.dart';
import '../../constants/values.dart';
import '../../widgets/detail_row.dart';
import '../../widgets/general_button.dart';
import '../../widgets/profile_info_heading.dart';
import '../constants/enums.dart';
import '../controllers/printer_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/dialogs/bottom_dialog.dart';

class LoadDetailModal extends StatelessWidget {
  final AssignedModel model;
  final bool isDispatch;

  const LoadDetailModal({
    Key? key,
    required this.model,
    this.isDispatch = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final p = context.watch<PrinterController>();

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
          mainAxisSize: MainAxisSize.min,
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
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ProfileInfoHeading(title: 'Package Information'),
                  DetailRow(title: 'Size: ', value: '${model.packageSize}'),
                  DetailRow(title: 'Weight: ', value: '${model.packageWeight}'),
                  DetailRow(title: 'Type: ', value: '${model.packageType}'),
                  // DetailRow(
                  //   title: 'Checkpoint: ',
                  //   value: 'Madhyapur Thimi -7',
                  // ),
                  DetailRow(
                    title: 'Price: ',
                    value: 'Rs. ${model.packagePrice}',
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GeneralButton(
                      color: FIELD_BACKGROUND,
                      child: const Text(
                        'VIEW ROUTE MAP',
                        style: TextStyle(
                          color: TEXT_BLUE,
                          fontSize: DETAILS_TEXT - 2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTab: () {
                        isDispatch
                            ? launch(
                                'https://www.google.com/maps/dir/?api=1&destination='
                                '${model.recieverLat},'
                                '${model.recieverLon}',
                              )
                            : launch(
                                'https://www.google.com/maps/dir/?api=1&destination='
                                '${model.senderLat},'
                                '${model.senderLon}',
                              );
                      },
                    ),
                  ),
                  const SizedBox(height: BASE_PADDING),
                  ProfileInfoHeading(
                    title: isDispatch
                        ? 'Receiver Information'
                        : 'Sender Information',
                  ),
                  DetailRow(
                    title: 'Name: ',
                    value: isDispatch
                        ? model.recieverName ?? ''
                        : model.senderName ?? '',
                  ),
                  DetailRow(
                    title: 'Address: ',
                    value: isDispatch
                        ? model.recieverAddress ?? ''
                        : model.senderAddress ?? '',
                  ),
                  DetailRow(
                    title: 'Mobile Number: ',
                    value: isDispatch
                        ? (model.recieverMobileno ?? '').toString()
                        : (model.senderMobileno ?? '').toString(),
                  ),
                  // DetailRow(title: 'Email: ', value: isDispatch
                  //     ? model.recieverAddress ?? ''
                  //     : model.senderAddress ?? '',),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GeneralButton(
                      color: FIELD_BACKGROUND,
                      child: Text(
                        isDispatch ? 'CALL RECEIVER' : 'CALL SENDER',
                        style: const TextStyle(
                          color: TEXT_BLUE,
                          fontSize: DETAILS_TEXT - 2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTab: () {
                        isDispatch
                            ? launch('tel:${model.recieverMobileno}')
                            : launch('tel:${model.senderMobileno}');
                      },
                    ),
                  ),
                  const SizedBox(height: BASE_PADDING),
                  if (!p.isConnected)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BASE_PADDING * 2,
                      ),
                      child: CustomButton(
                        title: 'Connect Printer',
                        onTab: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PrinterConnection(),
                            ),
                          );
                        },
                      ),
                    ),
                  if (p.isConnected && !p.isPrinting)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BASE_PADDING * 2,
                      ),
                      child: CustomButton(
                        title: p.isPrinting
                            ? 'Printing! Please Wait'
                            : 'Print Label',
                        onTab: () async {
                          if (p.isPrinting) {
                            return;
                          }

                          try {
                            p.printLabel(label: model.packageCode ?? '');
                          } catch (e) {
                            showBottomDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              title: 'Error',
                              message: e.toString(),
                            );
                          }
                        },
                      ),
                    ),
                  if (p.isPrinting)
                    const Padding(
                      padding: EdgeInsets.all(48.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  const SizedBox(height: BASE_PADDING),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
