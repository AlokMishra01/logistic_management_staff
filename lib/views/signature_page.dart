import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

import '../widgets/header.dart';

class SignaturePage extends StatefulWidget {
  final ValueChanged<File> onDone;

  const SignaturePage({
    Key? key,
    required this.onDone,
  }) : super(key: key);

  @override
  _SignaturePageState createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  late SignatureController controller;

  @override
  void initState() {
    super.initState();

    controller = SignatureController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const Header(
              title: 'Signature',
              backButton: true,
            ),
            Expanded(
              child: Signature(
                controller: controller,
                backgroundColor: Colors.white,
              ),
            ),
            const Divider(height: 1.0),
            buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget buildButtons(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildCheck(context),
            const VerticalDivider(width: 1.0),
            buildClear(),
          ],
        ),
      ),
    );
  }

  Widget buildCheck(BuildContext context) {
    return IconButton(
      iconSize: 36,
      icon: const Icon(
        Icons.check,
        color: Colors.green,
      ),
      onPressed: () async {
        if (controller.isNotEmpty) {
          final signature = await exportSignature();
          if (signature != null) {
            Directory tempDir = await getTemporaryDirectory();
            String tempPath = tempDir.path;
            File image = await File(
              '$tempPath/signature.png',
            ).writeAsBytes(signature);
            controller.clear();
            Navigator.pop(context);
            widget.onDone(image);
          }
        }
      },
    );
  }

  Widget buildClear() {
    return IconButton(
      iconSize: 36,
      icon: const Icon(
        Icons.clear,
        color: Colors.red,
      ),
      onPressed: () => controller.clear(),
    );
  }

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      points: controller.points,
    );

    final signature = await exportController.toPngBytes();
    exportController.dispose();

    return signature;
  }
}
