import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../design_system/components/my_app_bar.dart';
import 'package:sensors_plus/sensors_plus.dart';
class CompassPage extends StatefulWidget {
  const CompassPage({super.key});

  @override
  State<CompassPage> createState() => _CompassPageState();
}

class _CompassPageState extends State<CompassPage> {
  double _latitude=0.0;
  double _longitude=0.0;
  double rotateAngle=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determineLocation();
    userAccelerometerEventStream(samplingPeriod: SensorInterval.normalInterval).
    listen((UserAccelerometerEvent e){
      _determineLocation();
    },
      onError: (err)
        {
          print(err);
        }
    );
    magnetometerEventStream().listen(
        (MagnetometerEvent e)
            {
              double magAngle=atan2(e.y, e.x)*(180/pi);
              setState(() {
                rotateAngle=magAngle;
              });
            }
    );
  }
  Future<void> _determineLocation()async{
    LocationPermission permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){
        return Future.error("Location permissions are denied");
      }
    }
    Position myPosition=await Geolocator.getCurrentPosition();
    setState(() {
      _latitude=myPosition.latitude;
      _longitude=myPosition.longitude;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        margin: EdgeInsets.all(20),
      child: Center(
        child: Column(
          children:[
            Text("Ubicacion: ", style: TextStyle(fontWeight: FontWeight.bold),),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Latitude: $_latitude"),
              Text("Longitude: $_longitude"),
            ]),
            Text("Brujula: ", style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(
              height: 200,width: 200,
              child: Transform.rotate(angle: rotateAngle*(pi/180),
              child: Icon(Icons.navigation,
                color: Colors.red
              ),
            ),
            )
          ]
        ),
      ),
    )
    );
  }
}
