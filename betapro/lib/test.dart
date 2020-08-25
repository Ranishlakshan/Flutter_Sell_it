import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';

//void main() => runApp(Ranishl());

class Ranishl extends StatefulWidget {
  @override
  _RanishlState createState() => _RanishlState();
}

class _RanishlState extends State<Ranishl> {
  String _mobileNumber = '';
  List<SimCard> _simCard = <SimCard>[];
  List<String> ranish = <String>[];
  @override
  void initState() {
    super.initState();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });

    initMobileNumberState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    String mobileNumber = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      mobileNumber = await MobileNumber.mobileNumber;
      _simCard = await MobileNumber.getSimCards;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    
  }
  String phn;
  void fillCards() {
    List<Widget> widgets = _simCard
        .map((SimCard sim) => Text(
            '${sim.number}'))
        .toList();
    ranish = _simCard
        .map((SimCard sim) => (
            '${sim.number}'))
        .toList();    
    //return Column(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              //Text('Running on: $_mobileNumber\n'),
              //fillCards(),
              Text(ranish.toString())
            ],
          ),
        ),
      ),
    );
  }
}