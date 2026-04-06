import 'package:test/test.dart';
import '../lib/operaciones.dart';

void main(){
  //UNIT TEST
  //Prueba de suma
  group("Estas son pruebas de suma", ()
  {
    test('Este es un test de suma normal',()
    {
      final suma=Operaciones(num1: 5, num2: 12);
      double res = suma.suma();

      expect(res, 17.0);
    });
    test('Este es un test de suma con negativos',()
    {
      final suma=Operaciones(num1: 5, num2: -12);
      double res = suma.suma();

      expect(res, -7.0);
    });
    test('Este es un test de suma con el opuesto negativo',()
    {
      double valor=5;
      final suma=Operaciones(num1: valor, num2: (valor*(-1)));
      double res = suma.suma();

      expect(res, 0.0);
    });
  });
  //Prueba de resta
  group("Estos son tests de restas", ()
  {
    test('Este es un test de resta normal',()
    {
      final suma=Operaciones(num1: 12, num2: 5);
      double res = suma.resta();

      expect(res, 7);
    });
    test('Este es un test de resta entre negativos',()
    {
      final suma=Operaciones(num1: -8, num2: -5);
      double res = suma.resta();

      expect(res, -3);
    });
  });
  group("Estos son tests de división", ()
  {
    test('Este test prueba una división normal',()
    {
      final divi = Operaciones(num1: 10, num2: 2);
      double res = divi.division();
      expect(res,5.0);
    });
    test('Este test prueba una división con negativos',()
    {
      final divi = Operaciones(num1: 10, num2: -2);
      double res = divi.division();
      expect(res,-5.0);
    });
    test('Este test prueba una división por cero',()
    {
      final divi = Operaciones(num1: 10, num2: 0);
      double res = divi.division();
      expect(res,0.0);
    });
  });

}
