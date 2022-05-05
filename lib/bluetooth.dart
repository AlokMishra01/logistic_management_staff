import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothView extends StatefulWidget {
  const BluetoothView({Key? key}) : super(key: key);

  @override
  State<BluetoothView> createState() => _BluetoothViewState();
}

class _BluetoothViewState extends State<BluetoothView> {
  // Initializing a global key, as it would help us in showing a SnackBar later
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Get the instance of the bluetooth
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

  // Define some variables, which will be required later
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice? _device;
  bool _connected = false;
  bool _pressed = false;

  static const platform = MethodChannel('alok.dev/printer');

  @override
  void initState() {
    super.initState();
    bluetoothConnectionState();
  }

  // We are using async callback for using await
  Future<void> bluetoothConnectionState() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    // For knowing when bluetooth is connected and when disconnected
    // bluetooth.onStateChanged().listen((state) {
    //   switch (state) {
    //     case FlutterBluetoothSerial.CONNECTED:
    //       setState(() {
    //         _connected = true;
    //         _pressed = false;
    //       });
    //
    //       break;
    //
    //     case FlutterBluetoothSerial.DISCONNECTED:
    //       setState(() {
    //         _connected = false;
    //         _pressed = false;
    //       });
    //       break;
    //
    //     default:
    //       print(state);
    //       break;
    //   }
    // });
    //
    // // It is an error to call [setState] unless [mounted] is true.
    // if (!mounted) {
    //   return;
    // }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
    setState(() {
      _devicesList = devices;
    });
  }

  bool deviceConnected = false;
  bool isPrinting = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Flutter Bluetooth"),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _devicesList.length,
                itemBuilder: (_, i) {
                  return TextButton(
                    onPressed: () async {
                      // BluetoothConnection c = await BluetoothConnection.toAddress(
                      //   _devicesList[i].address,
                      // );

                      try {
                        deviceConnected = await platform.invokeMethod(
                          'connect',
                          {"address": _devicesList[i].address},
                        );
                        setState(() {});
                        log(
                          deviceConnected.toString(),
                          name: 'Printer Connected',
                        );
                      } on PlatformException catch (e, s) {
                        log(
                          e.message ?? '',
                          name: 'Print Error',
                          error: e,
                          stackTrace: s,
                        );
                      }
                      // log(c.toString());
                    },
                    child: Text(_devicesList[i].name ?? 'n/a'),
                  );
                },
              ),
            ),
            if (deviceConnected)
              TextButton(
                onPressed: () async {
                  isPrinting = true;
                  setState(() {});

                  String printed = await platform.invokeMethod(
                    'printLabel',
                    {
                      "label": 'AY68H068891',
                    },
                  );
                  log(printed, name: 'Printed Label');

                  isPrinting = false;
                  setState(() {});
                },
                child: const Text("Test Print"),
              ),
          ],
        ),
        // body: Container(
        //   // Defining a Column containing FOUR main Widgets wrapped with some padding:
        //   // 1. Text
        //   // 2. Row
        //   // 3. Card
        //   // 4. Text (wrapped with "Expanded" and "Padding")
        //   // child: Column(
        //   //   mainAxisSize: MainAxisSize.max,
        //   //   children: <Widget>[
        //   //     // Padding(
        //   //     //   padding: const EdgeInsets.only(top: 8.0),
        //   //     //   child: Text(
        //   //     //     "PAIRED DEVICES",
        //   //     //     style: TextStyle(fontSize: 24, color: Colors.blue),
        //   //     //     textAlign: TextAlign.center,
        //   //     //   ),
        //   //     // ),
        //   //     // Padding(
        //   //     //   padding: const EdgeInsets.all(8.0),
        //   //     //   // Defining a Row containing THREE main Widgets:
        //   //     //   // 1. Text
        //   //     //   // 2. DropdownButton
        //   //     //   // 3. RaisedButton
        //   //     //   child: Row(
        //   //     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   //     //     children: <Widget>[
        //   //     //       Text(
        //   //     //         'Device:',
        //   //     //         style: TextStyle(
        //   //     //           fontWeight: FontWeight.bold,
        //   //     //         ),
        //   //     //       ),
        //   //     //       // DropdownButton(
        //   //     //       //   // To be implemented : _getDeviceItems()
        //   //     //       //   items: _getDeviceItems(),
        //   //     //       //   onChanged: (value) => setState(() => _device = value),
        //   //     //       //   value: _device,
        //   //     //       // ),
        //   //     //       RaisedButton(
        //   //     //         onPressed:
        //   //     //             // To be implemented : _disconnect and _connect
        //   //     //             _pressed
        //   //     //                 ? null
        //   //     //                 : _connected
        //   //     //                     ? _disconnect
        //   //     //                     : _connect,
        //   //     //         child: Text(_connected ? 'Disconnect' : 'Connect'),
        //   //     //       ),
        //   //     //     ],
        //   //     //   ),
        //   //     // ),
        //   //     // Padding(
        //   //     //   padding: const EdgeInsets.all(16.0),
        //   //     //   child: Card(
        //   //     //     elevation: 4,
        //   //     //     child: Padding(
        //   //     //       padding: const EdgeInsets.all(8.0),
        //   //     //       // Defining a Row containing THREE main Widgets:
        //   //     //       // 1. Text (wrapped with "Expanded")
        //   //     //       // 2. FlatButton
        //   //     //       // 3. FlatButton
        //   //     //       child: Row(
        //   //     //         children: <Widget>[
        //   //     //           Expanded(
        //   //     //             child: Text(
        //   //     //               "DEVICE 1",
        //   //     //               style: TextStyle(
        //   //     //                 fontSize: 20,
        //   //     //                 color: Colors.green,
        //   //     //               ),
        //   //     //             ),
        //   //     //           ),
        //   //     //           FlatButton(
        //   //     //             onPressed:
        //   //     //                 // To be implemented : _sendOnMessageToBluetooth()
        //   //     //                 _connected ? _sendOnMessageToBluetooth : null,
        //   //     //             child: Text("ON"),
        //   //     //           ),
        //   //     //           FlatButton(
        //   //     //             onPressed:
        //   //     //                 // To be implemented : _sendOffMessageToBluetooth()
        //   //     //                 _connected ? _sendOffMessageToBluetooth : null,
        //   //     //             child: Text("OFF"),
        //   //     //           ),
        //   //     //         ],
        //   //     //       ),
        //   //     //     ),
        //   //     //   ),
        //   //     // ),
        //   //     // Expanded(
        //   //     //   child: Padding(
        //   //     //     padding: const EdgeInsets.all(20),
        //   //     //     child: Center(
        //   //     //       child: Text(
        //   //     //         "NOTE: If you cannot find the device in the list, "
        //   //     //         "please turn on bluetooth and pair the device by "
        //   //     //         "going to the bluetooth settings",
        //   //     //         style: TextStyle(
        //   //     //             fontSize: 15,
        //   //     //             fontWeight: FontWeight.bold,
        //   //     //             color: Colors.red),
        //   //     //       ),
        //   //     //     ),
        //   //     //   ),
        //   //     // )
        //   //   ],
        //   // ),
        // ),
      ),
    );
  }

  // // Create the List of devices to be shown in Dropdown Menu
  // List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
  //   List<DropdownMenuItem<BluetoothDevice>> items = [];
  //   if (_devicesList.isEmpty) {
  //     items.add(DropdownMenuItem(
  //       child: Text('NONE'),
  //     ));
  //   } else {
  //     _devicesList.forEach((device) {
  //       items.add(DropdownMenuItem(
  //         child: Text(device.name),
  //         value: device,
  //       ));
  //     });
  //   }
  //   return items;
  // }
  //
  // // Method to connect to bluetooth
  // void _connect() {
  //   if (_device == null) {
  //     show('No device selected');
  //   } else {
  //     bluetooth.isConnected.then((isConnected) {
  //       if (!isConnected) {
  //         bluetooth
  //             .connect(_device)
  //             .timeout(Duration(seconds: 10))
  //             .catchError((error) {
  //           setState(() => _pressed = false);
  //         });
  //         setState(() => _pressed = true);
  //       }
  //     });
  //   }
  // }
  //
  // // Method to disconnect bluetooth
  // void _disconnect() {
  //   bluetooth.disconnect();
  //   setState(() => _pressed = true);
  // }
  //
  // // Method to show a Snackbar,
  // // taking message as the text
  // Future show(
  //   String message, {
  //   Duration duration: const Duration(seconds: 3),
  // }) async {
  //   await new Future.delayed(new Duration(milliseconds: 100));
  //   _scaffoldKey.currentState?.showSnackBar(
  //     new SnackBar(
  //       content: new Text(
  //         message,
  //       ),
  //       duration: duration,
  //     ),
  //   );
  // }
}
