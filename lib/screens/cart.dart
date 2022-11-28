import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screens/upiTransaction.dart';


class CartScreen extends StatefulWidget {
  
  @override
  State<CartScreen> createState() => _CartScreenState();

}

class _CartScreenState extends State<CartScreen> {
   int totalPrice=0;
  final querydb = FirebaseDatabase(databaseURL: "https://news-a3e9f-default-rtdb.asia-southeast1.firebasedatabase.app").ref().child("orders");

  final databaseRef = FirebaseDatabase(databaseURL: "https://news-a3e9f-default-rtdb.asia-southeast1.firebasedatabase.app").ref().child("orders");
  Map orders = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(backgroundColor: Colors.grey[600],title: Text("Cart"),),
        body:
        Column(
          children: [
            Expanded(
              flex: 11,
              child: FirebaseAnimatedList(query: querydb,
                itemBuilder:(BuildContext context , DataSnapshot snapshot,Animation<double> animation, int index)
              {
                orders = snapshot.value as Map;
                orders['key'] = snapshot.key;
                return listItem(orders: orders);
              } ,
              ),
            ),

            Expanded(
              flex: 1,
              child: Container(
                color: Colors.grey[900],
                child: Row(
                  children: [
                   // SizedBox(width: 10,),
                   //  Text("Total :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                   //  Text("$totalPrice",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                     SizedBox(width: 40,),
                  Text("CheckOut",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                    SizedBox(width: 10,),
                    GestureDetector(onTap:()
                    {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpiTransaction(amount: totalPrice)));
                    },
                        child: Icon(Icons.arrow_circle_right_outlined,color: Colors.white,),)
                  ],
                ),
              ),
            )
          ],
        ),


    );
    setState((){ totalPrice += int.parse(orders['price']);});
  }




  Widget listItem({required Map orders}){
    totalPrice += int.parse(orders['price']);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(colors: [
              Colors.grey.withOpacity(0.9),
              Colors.white.withOpacity(1),
            ])
        ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0,0,8,0),
              child: Row(
                
                children: [
                  Expanded(flex: 1,
                      child: CircleAvatar(backgroundImage: NetworkImage(orders['img']),radius: 45,)),

                  Expanded(flex: 3,
                    child: Column(

                      children: [

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,8,0,0),
                          child: Align(alignment: Alignment.centerLeft,
                              child: Text("Title : " +orders['title'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                        ),
                          SizedBox(height: 10,),
                        Row(
                          children: [
                                SizedBox(width: 10,),
                            Expanded(
                                child: Text("Price : " +orders['price'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),

                            Expanded(
                              child: ElevatedButton(
                                onPressed: (){
                                },
                                child: Text("Buy"),
                                style: ButtonStyle(
                                    backgroundColor:MaterialStateProperty.all(Colors.grey[600])
                                ),
                              ),
                            ),

                            Expanded(
                              child: Align(alignment: Alignment.bottomRight,
                                child: IconButton(onPressed: (){
                                  databaseRef.child(orders['key']).remove();
                                  setState((){
                                   totalPrice -=  int.parse(orders['price']);
                                  });
                                }, icon: Icon(Icons.delete)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
      ),
    );
  }

  // @override
  // void deactivate() {
  //
  //     databaseRef.child(orders['key']).remove(); super.deactivate();
  // }

  // @override
  // void dispose() {
  //
  //   databaseRef.child(orders['key']).remove();
  //   super.dispose();
  // }
}

