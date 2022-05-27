import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';

import '/models/assigned_response_model.dart';
import '/models/pickup_response_model.dart';
import '/views/available_order_detail_mosal.dart';
import '../../constants/colors.dart';
import '../../constants/values.dart';
import '../../widgets/detail_row.dart';

class OrderListItem extends StatelessWidget {
  final bool isPickOff;
  final PickupDataModel pickup;
  final AssignedModel assign;

  const OrderListItem({
    Key? key,
    required this.pickup,
    required this.assign,
    this.isPickOff = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: BASE_PADDING),
          padding: const EdgeInsets.symmetric(horizontal: BASE_PADDING / 1.25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RADIUS),
            // color: GREEN,
            color: pickup.id != null
                ? BLUE_BACKGROUND
                : assign.status == 'Delivered'
                    ? GREEN
                    : BLUE_BACKGROUND,
          ),
          child: Column(
            children: [
              const SizedBox(height: BASE_PADDING / 1.25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailRow(
                        title: "Time",
                        value: isPickOff
                            ? (pickup.pickupTime ?? '').isEmpty
                                ? ''
                                : Jiffy(pickup.pickupTime, "H:m:s").jm
                            : (assign.dropoffTime ?? '').isEmpty
                                ? ''
                                : Jiffy(assign.dropoffTime, "H:m:s").jm,
                      ),
                      const Text(
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
                        value: isPickOff
                            ? "${pickup.senderName}"
                            : "${assign.recieverName}",
                      ),
                      DetailRow(
                        title: "Address",
                        value: isPickOff
                            ? "${pickup.recieverAddress}"
                            : "${assign.recieverAddress}",
                      ),
                      DetailRow(
                        title: "Contact",
                        value: isPickOff
                            ? "${pickup.senderMobileno}"
                            : "${assign.recieverMobileno}",
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: TEXT_BLUE,
                    child: IconButton(
                      icon: const Icon(
                        CupertinoIcons.phone_fill,
                        color: TEXT_WHITE,
                      ),
                      onPressed: () {
                        isPickOff
                            ? launch('tel: ${pickup.senderMobileno}')
                            : launch('tel: ${assign.recieverMobileno}');
                      },
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
                    child: Text(
                      isPickOff
                          ? "${pickup.packageWeight} Kg."
                          : "${assign.packageWeight} Kg.",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
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
                        builder: (_) => AvailableOrderDetailModal(
                          pickup: isPickOff ? pickup : PickupDataModel(),
                          assign: isPickOff ? AssignedModel() : assign,
                          isPickOff: isPickOff,
                        ),
                        isScrollControlled: true,
                        backgroundColor: TEXT_WHITE,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(RADIUS),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(CupertinoIcons.ellipsis),
                    color: TEXT_BLUE,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Text(
                      isPickOff
                          ? 'NRs. ${pickup.packagePrice ?? 0.0}'
                          : 'NRs. ${assign.packagePrice ?? 0.0}',
                      textAlign: TextAlign.end,
                      style: const TextStyle(
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
                builder: (_) => AvailableOrderDetailModal(
                  pickup: isPickOff ? pickup : PickupDataModel(),
                  assign: isPickOff ? AssignedModel() : assign,
                  isPickOff: isPickOff,
                ),
                isScrollControlled: true,
                backgroundColor: TEXT_WHITE,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(RADIUS),
                  ),
                ),
              );
            },
            icon: const Icon(CupertinoIcons.ellipsis),
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
