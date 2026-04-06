import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
void main()
{
    final btnFinder = find.byValueKey("btnFloating");
    final txtFinder = find.byValueKey("txtCount");

    late final FlutterDriver driver;

    setUpAll(()async{
      driver = await FlutterDriver.connect();
    });

    test("Prueba de integración de main",()async
    {
      await driver.tap(btnFinder);
      final res = await driver.getText(txtFinder);

      expect(res, "1");
    });

    tearDownAll((){
      //driver.close();
    });


}