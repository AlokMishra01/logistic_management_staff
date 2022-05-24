import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/enums.dart';
import '../constants/values.dart';
import '../controllers/printer_controller.dart';
import '../widgets/dialogs/bottom_dialog.dart';
import '../widgets/dialogs/loading_dialog.dart';
import '../widgets/header.dart';

class PrinterConnection extends StatefulWidget {
  const PrinterConnection({Key? key}) : super(key: key);

  @override
  State<PrinterConnection> createState() => _PrinterConnectionState();
}

class _PrinterConnectionState extends State<PrinterConnection> {
  @override
  Widget build(BuildContext context) {
    final printer = context.watch<PrinterController>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Header(
              title: 'Printer',
              backButton: true,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(BASE_PADDING * 2),
                child: RefreshIndicator(
                  onRefresh: () => printer.searchDevices(),
                  child: ListView.separated(
                    itemBuilder: (_, i) {
                      return ListTile(
                        dense: true,
                        leading: const Icon(
                          CupertinoIcons.bluetooth,
                          color: BUTTON_BLUE,
                        ),
                        title: Text(
                          printer.bluetoothDevices[i].name ?? 'N/a',
                          style: const TextStyle(
                            color: TEXT_BLACK,
                            fontSize: TITLE_TEXT,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () async {
                          final progressDialog = getProgressDialog(
                            context: context,
                          );
                          progressDialog.show(useSafeArea: false);

                          final res = await printer.connectDevice(
                            device: printer.bluetoothDevices[i],
                          );

                          progressDialog.dismiss();

                          if ((res ?? '').isEmpty) {
                            Navigator.pop(context);
                          } else {
                            showBottomDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              title: 'Error',
                              message: res.toString(),
                            );
                          }
                        },
                      );
                    },
                    separatorBuilder: (_, i) => const SizedBox(
                      height: BASE_PADDING,
                    ),
                    itemCount: printer.bluetoothDevices.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<PrinterController>().searchDevices();
  }
}
