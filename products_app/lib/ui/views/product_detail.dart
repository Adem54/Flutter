import 'package:flutter/material.dart';
import 'package:products_app/data/entity/product.dart';

class ProductDetail extends StatefulWidget {
  Product product;

  ProductDetail({required  this.product});

  //const ProductDetail({super.key});
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}
//Hatirlayalim...bu detail sayfasina gelen product , products sayfasindan gonderiliyor
// ProductDetail in paramtersinden, burda ui da widget larda kullanirken widget.product..
// widget.product.title  diyerek goruntuleybiliyrduk bunu unutmayalim
class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.title)),
      body:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.network(widget.product.image, width: 140,height: 140,fit:BoxFit.cover),
            SizedBox(width:150, height: 150, child: Image.asset("images/${widget.product.image}")),
            Text("${widget.product.price.toString()} €",style:TextStyle(fontSize: 50))
          ],
        )
      )
    );
  }
}
