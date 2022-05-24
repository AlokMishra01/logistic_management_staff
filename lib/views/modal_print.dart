import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/values.dart';
import '../controllers/printer_controller.dart';
import '../widgets/custom_button.dart';
import 'printer_connection.dart';

class ModalPrint extends StatelessWidget {
  final String barcode;

  const ModalPrint({
    Key? key,
    required this.barcode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final p = context.watch<PrinterController>();
    return Scaffold(
      body: Column(
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
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: BASE_PADDING * 2,
            ),
            child: Text(
              'You have successfully picked up package.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: TEXT_SECONDARY,
                fontSize: SUB_HEADER_TEXT,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: BASE_PADDING),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(BASE_PADDING * 2),
              child: Center(
                child: BarcodeWidget(
                  barcode: Barcode.code39(),
                  height: 100,
                  data: barcode,
                ),
              ),
            ),
          ),
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
                title: p.isPrinting ? 'Printing! Please Wait' : 'Print Label',
                onTab: () async {
                  if (p.isPrinting) {
                    return;
                  }

                  try {
                    p.printLabel(label: barcode);
                  } catch (e) {
                    p.searchDevices();
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
    );
  }
}
