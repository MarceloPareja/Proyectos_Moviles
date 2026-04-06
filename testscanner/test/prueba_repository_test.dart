import 'package:test/test.dart';
import '../lib/domain/entities/prueba.dart';
import '../lib/data/remote_repositories/prueba_repository.dart';
void main(){
  test("Prueba, lista de pruebas",(){
    String numero="23";
    int? result=int.tryParse(numero);
    expect(result, 23);
  });
}