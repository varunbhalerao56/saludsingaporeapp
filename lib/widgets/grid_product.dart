import 'package:flutter/material.dart';
import 'package:saludsingapore/models/product.dart';
import 'package:saludsingapore/models/user.dart';
import 'package:scoped_model/scoped_model.dart';


class GridProduct extends StatelessWidget {

  final String name;
  final String img;
  final bool isFav;
  final double rating;
  final int raters;
  final Products product;


  GridProduct({
    Key key,
    @required this.name,
    @required this.img,
    @required this.isFav,
    @required this.rating,
    @required this.raters, this.product})
      :super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppUser>(builder: (context, child, model)
    {
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 3.6,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    "$img",
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                right: -10.0,
                bottom: 3.0,
                child: RawMaterialButton(
                  onPressed: () {},
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  elevation: 4.0,
                  child: Icon(
                    isFav
                        ?Icons.favorite
                        :Icons.add,
                    color: Colors.red,
                    size: 17,
                  ),
                ),
              ),
            ],


          ),

          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              "$name",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
              ),
              maxLines: 2,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
            child: Row(
              children: <Widget>[
                Text(
                 "\$" + product.productPrice.toString(),
                  style: TextStyle(
                    fontSize: 11.0,
                  ),
                ),

              ],
            ),
          ),


        ],
      ),
    );
  });
}
}