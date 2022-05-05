import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class PrinterController with ChangeNotifier {
  static const _printerPlatform = MethodChannel('alok.dev/printer');
  final _bluetooth = FlutterBluetoothSerial.instance;

  final List<BluetoothDevice> _bluetoothDevices = [];

  bool _isConnected = false;
  bool _isSearching = false;
  bool _isConnecting = false;
  bool _isPrinting = false;

  searchDevices() async {
    try {
      _isSearching = true;
      notifyListeners();

      _bluetoothDevices
        ..clear()
        ..addAll(await _bluetooth.getBondedDevices());
    } on PlatformException catch (error, stackTrace) {
      log('Bluetooth Connection Error!', error: error, stackTrace: stackTrace);
    } catch (error, stackTrace) {
      log('Bluetooth Connection Error!', error: error, stackTrace: stackTrace);
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  connectDevice({required BluetoothDevice device}) async {
    try {
      _isConnecting = true;
      _isConnected = false;
      notifyListeners();

      await _printerPlatform.invokeMethod(
        'connect',
        {"address": device.address},
      );
      _isConnecting = false;
    } on PlatformException catch (error, stackTrace) {
      log('Printer Connection Error!', error: error, stackTrace: stackTrace);
    } catch (error, stackTrace) {
      log('Printer Connection Error!', error: error, stackTrace: stackTrace);
    }

    _isConnecting = false;
    _isConnected = await _printerPlatform.invokeMethod(
      'connect',
      {"address": device.address},
    );
    notifyListeners();
  }

  Future<String> printLabel({required String label}) async {
    try {
      _isPrinting = true;
      notifyListeners();

      String printed = await _printerPlatform.invokeMethod(
        'printLabel',
        {"label": label},
      );

      log(printed, name: 'Printing Label');

      _isPrinting = false;
      notifyListeners();

      return '';
    } on PlatformException catch (error, stackTrace) {
      log('Printing Label Error!', error: error, stackTrace: stackTrace);

      _isPrinting = false;
      notifyListeners();

      return '${error.code}: ${error.message}! ${error.details}';
    } catch (error, stackTrace) {
      log('Printing Label Error!', error: error, stackTrace: stackTrace);

      _isPrinting = false;
      notifyListeners();

      return error.toString();
    }
  }

  List<BluetoothDevice> get bluetoothDevices => _bluetoothDevices;
  bool get isConnected => _isConnected;
  bool get isSearching => _isSearching;
  bool get isConnecting => _isConnecting;
  bool get isPrinting => _isPrinting;
}
