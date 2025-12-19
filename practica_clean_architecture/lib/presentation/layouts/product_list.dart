import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de productos"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, "/detail");
      },
      child: Icon(Icons.add_outlined),),
      body: ListView.builder(itemCount: provider.products.length,
      itemBuilder: (context, index){
        final product=provider.products[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text(product.price.toString()),
          onTap: (){
            Navigator.pushNamed(context, "/edit",arguments: product);
          },
        );
      }),
    );
  }
}
