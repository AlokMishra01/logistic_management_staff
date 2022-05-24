package com.ikima.delivery;


import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.ikima.delivery.R;
import com.prowesspride.api.Printer_ESC;
import com.prowesspride.api.Printer_GEN;
import com.prowesspride.api.Setup;

import java.io.InputStream;
import java.io.OutputStream;

import bluetooth.BluetoothComm;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String PRINTER_CHANNEL = "alok.dev/printer";

    Context context = this;

    static Setup setup = null;
    private BluetoothComm bluetoothComm;
    Printer_GEN printerGen;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        try {
            setup = new Setup();

            boolean activate = setup.blActivateLibrary(context, R.raw.licencefull);

            if (activate) {
                Log.d("ProwessPrideSDK","SDK Activated");
            } else {
                Log.d("ProwessPrideSDK","SDK Not Activated");
            }
        } catch (Exception e) {
            e.printStackTrace();
            Log.e("ProwessPrideSDK", e.getMessage());
        }
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        MethodChannel printer = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), PRINTER_CHANNEL);
        printer.setMethodCallHandler(
                (call, result) -> {
                    switch (call.method) {
                        case "connect":
                            if (!call.hasArgument("address")) {
                                result.error("Invalid Argument", "Argument 'address' not found", null);
                            }
                            String address = call.argument("address");
                            boolean connected = connectPrinter(address, result);
                            result.success(connected);
                            break;
                        case "isConnected":
                            boolean isConnected = isConnected(result);
                            result.success(isConnected);
                            break;
                        case "printLabel":
                            if (!call.hasArgument("label")) {
                                result.error("Invalid Argument", "Argument 'address' not found", null);
                            }
                            String labelURI = call.argument("label");
                            String printStatus = printLabel(labelURI, result);
                            result.success(printStatus);
                            break;
                        default:
                            result.notImplemented();
                    }
                }
        );
    }

    boolean connectPrinter(String address, MethodChannel.Result result) {
        try {
            if (!BluetoothAdapter.checkBluetoothAddress(address)) {
                result.error("Printer Connection Error", "Invalid Device", "Device " + address + "not found");
            }
            bluetoothComm = new BluetoothComm(address);
            boolean b = bluetoothComm.createConn();

            InputStream inputStream = BluetoothComm.misIn;
            OutputStream outStream = BluetoothComm.mosOut;
            printerGen = new Printer_GEN(setup, outStream, inputStream);

            return b;
        } catch (Exception exception) {
            result.error("Printer Connection Error", exception.getMessage(), exception.toString());
            return false;
        }
    }

    boolean isConnected(MethodChannel.Result result) {
        if (bluetoothComm == null) {
            result.error("Printer Connection Error", "Initialization Error", "Printer is not connected. Please connect printer.");
            return false;
        }

        return bluetoothComm.isConnect();
    }

    String printLabel(String label, MethodChannel.Result result) {
        if (printerGen == null) {
            result.error("SDK Initialization Error", "Initialization Error", "SDK is not Initialized. Please initialized SDK.");
            return "SDK Initialization Error";
        }
        try {
            int printResult = printerGen.iBarcodePrint(Printer_GEN.BARCODE_3OF9_UNCOMPRESSED, label);
            int printResult3 = printerGen.iAddData(Printer_GEN.FONT_LARGE_BOLD, label);
            int printResult4 = printerGen.iStartPrinting(1);
            int printResult5 = printerGen.iPaperFeed();
            int printResult6 = printerGen.iFlushBuf();
            return sCheckRetCode(printResult) + ", " + sCheckRetCode(printResult3) + ", " + sCheckRetCode(printResult4) + ", " + sCheckRetCode(printResult5) + ", " + sCheckRetCode(printResult6);
        } catch (Exception exception) {
            result.error("Conversion Error", "Bmp Conversion Error", exception.toString());
            return exception.getMessage();
        }

    }

    private static String sCheckRetCode(int iRetValue) {
        switch (iRetValue) {
            case Printer_ESC.SUCCESS:
                return "SUCCESS";
            case Printer_ESC.FAILURE:
                return "FAILURE";
            case Printer_ESC.NOT_SUPPORTED:
                return "NOT SUPPORTED";
            case Printer_ESC.NO_RESPONSE:
                return "NO RESPONSE";
            case Printer_ESC.NOT_ACTIVATED:
                return "NOT INITIALIZED";
            case Printer_ESC.PARAM_ERROR:
                return "PARAM ERROR";
            case Printer_ESC.DEMO_VERSION:
                return "DEMO VERSION";
            case Printer_ESC.INVALID_DEVICE_ID:
                return "INVALID DEVICE ID";
            case Printer_ESC.PAPER_OUT:
                return "PAPER OUT";
            case Printer_ESC.PLATEN_OPEN:
                return "PLATEN OPEN";
            case Printer_ESC.HIGH_HEADTEMP:
                return "HEAD TEMP HIGH";
            case Printer_ESC.LOW_HEADTEMP:
                return "HEAD TEMP LOW";
            case Printer_ESC.IMPROPER_VOLTAGE:
                return "IMPROPER VOLTAGE";
            case Printer_ESC.BMP_FILE_ERROR:
                return "FILE ERROR";
            case Printer_ESC.NO_DATA:
                return "NO DATA";
            default:
                return "Invalid Error : " + iRetValue;
        }

    }
}
