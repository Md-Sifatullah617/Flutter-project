import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:printer/controller/home_page_ctrl.dart';

class PrinterPage extends StatefulWidget {
  const PrinterPage({super.key});

  @override
  State<PrinterPage> createState() => _PrinterPageState();
}

class _PrinterPageState extends State<PrinterPage> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];
  String _devicesMsg = "";
  final f = NumberFormat("\$###,###.00", "en_US");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initPrinter());
  }

  Future<void> initPrinter() async {
    bluetoothPrint.startScan(timeout: const Duration(seconds: 2));

    if (!mounted) return;
    bluetoothPrint.scanResults.listen(
      (val) {
        if (!mounted) return;
        setState(() => _devices = val);
        if (_devices.isEmpty) {
          setState(() {
            _devicesMsg = "No Devices";
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Printer"),
      ),
      body: _devices.isEmpty
          ? Center(
              child: Text(_devicesMsg),
            )
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (contex, index) {
                return ListTile(
                  leading: const Icon(Icons.print),
                  title: Text(_devices[index].name ?? ""),
                  subtitle: Text(_devices[index].address ?? ""),
                  onTap: () async {
                    bluetoothPrint
                        .connect(_devices[index])
                        .then((value) => Get.find<HomepageController>()
                            .isPrinterConnected
                            .value = true)
                        .onError((error, stackTrace) {
                      Get.snackbar(
                        "Error",
                        error.toString(),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return Get.find<HomepageController>()
                          .isPrinterConnected
                          .value = false;
                    });
                  },
                );
              },
            ),
    );
  }
}
