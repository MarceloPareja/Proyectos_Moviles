import '../repositories/product_repository.dart';
import '../entities/product.dart';

class GetProducts{
  final ProductRepository repository;
  GetProducts(this.repository);

  List call()=>repository.getProducts();//Llamada a la clase abstracta
}