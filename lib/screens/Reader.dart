import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/screens/cart.dart';
import 'package:news_app/readData.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({Key? key}) : super(key: key);

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  List<String> articles = [];

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(

        appBar: AppBar(backgroundColor: Colors.grey,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Articles"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(onPressed: (){
                      Navigator.pushNamed(context, 'cart');
                    }
                        , icon: Icon(Icons.shopping_cart,size: 20,color: Colors.black,))
                  ),
                ],
              ),
            ],
          ),
        ),

        body: Container(
          color: Colors.grey[100],
          child: FutureBuilder(
            future:  getDocId(),
            builder: ( context,snapshot) {
              return new ListView.builder(
                itemBuilder: (context ,index){
                  return new ReadData(articles[index]);
                },
                itemCount: articles.length,);
            },
          ),
        )
      );
  }

   Future getDocId() async{
      await FirebaseFirestore.instance.collection("Articles").get().then(
              (snapshot) => snapshot.docs.forEach((document) {
                articles.add(document.reference.id);
              }) );
   }
}
