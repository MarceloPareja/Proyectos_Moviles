import 'package:flutter/material.dart';
import 'package:practica_clean_architecture/domain/useCases/addProduct.dart';
import '../../domain/useCases/getProducts.dart';
import '../../domain/entities/product.dart';
import '../../domain/useCases/updateProduct.dart';
import '../../domain/useCases/deleteProduct.dart';

class ProductProvider extends ChangeNotifier{
  final GetProducts getProductsUseCase;
  final AddProduct addProductsUseCase;
  final UpdateProduct updateProductsUseCase;
  final DeleteProduct deleteProductsUseCase;

  ProductProvider({
    required this.getProductsUseCase,
    required this.addProductsUseCase,
    required this.updateProductsUseCase,
    required this.deleteProductsUseCase,
  });

  List get products => getProductsUseCase();
  void add(Product product){
    addProductsUseCase(product);
    notifyListeners();
  }
  void update(Product product){
    updateProductsUseCase(product);
    notifyListeners();
  }
  void delete(String id) {
    deleteProductsUseCase(id);
    notifyListeners();
  }

}