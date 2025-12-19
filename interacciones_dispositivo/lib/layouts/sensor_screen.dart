import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:geolocator/geolocator.dart';
class SensorScreen extends StatefulWidget {
  const SensorScreen({super.key});

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  double acc_x=0.0;
  double acc_y=0.0;
  double acc_z=0.0;
  double gyro_x=0.0;
  double gyro_y=0.0;
  double gyro_z=0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userAccelerometerEventStream(samplingPeriod: SensorInterval.normalInterval)
        .listen(
        (UserAccelerometerEvent e){
          print(e);
          setState(() {
            acc_x=e.x;
            acc_y=e.y;
            acc_z=e.z;
          });
        },
        onError: (err){
          print(err);
        }
    );
    gyroscopeEventStream(samplingPeriod: SensorInterval.normalInterval)
        .listen(
            (GyroscopeEvent e){
          print(e);
          gyro_x=e.x;
          gyro_y=e.y;
          gyro_z=e.z;
        },
        onError: (err){
          print(err);
        }
    );
  }

  Future<void> _determinePosition() async{

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sensor Screen"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Container(
        child: Center(
          child: Column(
            spacing: 10,
            children: [
              Text("Acelerometro",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("x=${acc_x}"),
              Text("y=${acc_y}"),
              Text("z=${acc_z}"),
              Text("Giroscopio",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("x=${gyro_x}"),
              Text("y=${gyro_y}"),
              Text("z=${gyro_z}"),
            ],
          )

        ),
      ),
    );
  }
}
