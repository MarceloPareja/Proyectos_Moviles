import '../../domain/entities/product.dart';
class ProductMemoryDatasources {
  final List<Product> _products = [];
  List<Product> getAll() => _products;
  //agregar el objeto
  void add(Product product)=> _products.add(product);
  
  void update(Product product){
    final index = _products.indexWhere(
        (e)=>e.id==product.id);
    if(index != -1) _products[index] = product;
  }

  void delete(String id){
    _products.removeWhere(
      (e)=>e.id==id
    );
  }

}