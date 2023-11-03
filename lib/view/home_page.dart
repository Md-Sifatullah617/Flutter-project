import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:printer/controller/home_page_ctrl.dart';
import 'package:printer/view/end_drawer.dart';
import 'package:printer/view/printer_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomepageController controller = Get.put(HomepageController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late StreamSubscription<DateTime> timerSubscription;
  String currentTime = '';
  String currentDate = '';

  @override
  void initState() {
    super.initState();
    startRealTimeClock();
  }

  void startRealTimeClock() {
    timerSubscription =
        Stream<DateTime>.periodic(const Duration(seconds: 1), (count) {
      return DateTime.now();
    }).listen((dateTime) {
      setState(() {
        currentTime = DateFormat('hh:mm a').format(dateTime);
        currentDate = DateFormat('dd-MM-yyyy').format(dateTime);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: const Text('Token Pro',
              style: TextStyle(color: Colors.deepPurple)),
          actions: [
            //change language button eng and bng text selected button color purple
            Container(
              height: Get.height * 0.03,
              width: Get.width * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Obx(
                    () => Positioned(
                      left: controller.isSelected.value ? 0 : null,
                      right: controller.isSelected.value ? null : 0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: Get.height * 0.03,
                        width: Get.width * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.isSelected.value = true;
                        },
                        child: const Text(
                          'Eng',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.isSelected.value = false;
                        },
                        child: const Text(
                          'Bng',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
            ),
          ],
        ),
        endDrawer: EndDrawer(scaffoldKey: _scaffoldKey),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(),
              Column(
                children: [
                  Obx(
                    () => controller.isPrinterConnected.value
                        ? const Text('Connected',
                            style: TextStyle(fontSize: 20, color: Colors.green))
                        : const Text('no service connected',
                            style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date: $currentDate\nTime: $currentTime',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 24)),
                      IconButton(
                          onPressed: () {
                            Get.to(() => const PrinterPage());
                          },
                          icon: const Icon(Icons.bluetooth_connected,
                              color: Colors.deepPurple))
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Container(
                    height: Get.height * 0.07,
                    width: Get.width,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                    text: "Today's generated token\n0",
                                    style: TextStyle(color: Colors.black))),
                          ),
                          Container(
                              height: Get.height * 0.07,
                              width: Get.width * 0.15,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                              ),
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              )),
                        ]),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: Get.height * 0.2,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(25)),
                      child: const Text(
                        'Click here\nto\ngenerate token',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red, fontSize: 24),
                      ))
                ],
              ),
              Positioned(
                bottom: Get.height * 0.03,
                child: Container(
                  height: Get.height * 0.07,
                  width: Get.width * 0.7,
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.shade100,
                  ),
                  child: GNav(
                      rippleColor: Colors.grey.shade800,
                      tabBorderRadius: 25,
                      duration: const Duration(milliseconds: 400),
                      gap: 8,
                      color: Colors.grey[800],
                      activeColor: Colors.purple,
                      iconSize: 24,
                      tabBackgroundColor: Colors.grey.withOpacity(0.2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      tabs: [
                        const GButton(
                          icon: FontAwesomeIcons.house,
                          text: 'Home',
                        ),
                        GButton(
                          onPressed: () {},
                          icon: FontAwesomeIcons.bell,
                          text: 'Notification',
                        ),
                        GButton(
                          onPressed: () {},
                          icon: FontAwesomeIcons.user,
                          text: 'Profile',
                        )
                      ]),
                ),
              ),
            ],
          ),
        ));
  }
}
