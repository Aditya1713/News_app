import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/screens/cart.dart';
import 'package:firebase_database/firebase_database.dart';

class ReadData extends StatelessWidget {
  final String docid;int totalPrice=0;
  final databaseRef = FirebaseDatabase(databaseURL: "https://news-a3e9f-default-rtdb.asia-southeast1.firebasedatabase.app").ref();

  ReadData(@required this.docid);

  Map<String, dynamic> info ={};
  @override
  Widget build(BuildContext context) {

    CollectionReference user = FirebaseFirestore.instance.collection("Articles");

    return FutureBuilder<DocumentSnapshot>(
      future: user.doc(docid).get(),
      builder: ((context , snapshot){

       if(snapshot.connectionState==ConnectionState.done) {
          info = snapshot.data!.data() as Map<String,dynamic>;
          return
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2,color: Colors.grey),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(50) ,bottomRight:  Radius.circular(50)),
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.withOpacity(0.9),
                    Colors.white.withOpacity(1),
                  ]
                )
              ),

              child:new  ListTile(
                title: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Image.network(info['img'],height: 200,)),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text("Title: ${info['title']}"),
                    SizedBox(height: 0,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [

            Expanded(child: Text("Price: ${info['price']}")),

            Expanded(child: Text("Discount: ${info['disPrice']}")),

            Container(decoration: BoxDecoration(border: Border.all(width: 1),borderRadius: BorderRadius.circular(40)),
                      child: Expanded(
                          child: IconButton(onPressed: returnCart ,
                            icon: Icon(Icons.add_shopping_cart_rounded),color: Colors.black,)))
                        ],
                      ),
                    )
                  ],
                ),
              ),

          ),
            );
        }
       return Text("loading......");
      })
    );
  }
  Future returnCart() async{

      final ref = databaseRef.child("orders");
      Map<String,dynamic> details = {
        'img': info['img'],
        'title':info['title'],
        'price':info['disPrice'],
      };

      ref.push().set(details);
  }
}

