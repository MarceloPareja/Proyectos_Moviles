import '../../domain/entities/product.dart';
import '../../data/datasources/product_memory_datasources.dart';
class ProductRepositoryImpl{
  final ProductMemoryDatasources datasource;
  ProductRepositoryImpl(this.datasource);

  @override
  List<Product> getProducts() => datasource.getAll();

  @override
  void addProduct(Product product) => datasource.add(product);

  @override
  void updateProduct(Product product) => datasource.update(product);

  @override
  void deleteProduct(String id) => datasource.delete(id);
}