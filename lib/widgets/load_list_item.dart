import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistic_management_staff/models/assigned_response_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.dart';
import '../../constants/values.dart';
import '../../widgets/detail_row.dart';
import '../views/load_detail_model.dart';

class LoadListItem extends StatelessWidget {
  final AssignedModel model;
  final bool isDispatch;

  const LoadListItem({
    Key? key,
    required this.model,
    this.isDispatch = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: BASE_PADDING),
      padding: const EdgeInsets.symmetric(horizontal: BASE_PADDING / 1.25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RADIUS),
        color: isDispatch
            ? BUTTON_GREEN.withOpacity(0.1)
            : BUTTON_BLUE.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: BASE_PADDING),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              child: const Icon(
                CupertinoIcons.map,
                color: TEXT_BLUE,
              ),
              onTap: () {
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
          const SizedBox(height: BASE_PADDING / 1.25),
          // DetailRow(
          //   title: "Size: ",
          //   value: "${model.packageSize}",
          // ),
          DetailRow(
            title: "Customer Name: ",
            value: isDispatch ? "${model.recieverName}" : "${model.senderName}",
          ),
          DetailRow(
            title: "Address: ",
            value: isDispatch
                ? "${model.recieverAddress}"
                : "${model.senderAddress}",
          ),
          DetailRow(
            title: "Contact: ",
            value: isDispatch
                ? "${model.recieverMobileno}"
                : "${model.senderMobileno}",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Text(
                  "${model.packageWeight} Kg.",
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
                    builder: (_) => LoadDetailModal(
                      model: model,
                      isDispatch: isDispatch,
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
                  'NRs. ${model.packagePrice ?? 0.0}',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: DETAILS_TEXT,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
