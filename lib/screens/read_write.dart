import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/Witer.dart';

import 'loginScreen.dart';

class ReadWriteScreen extends StatefulWidget {
  const ReadWriteScreen({Key? key}) : super(key: key);

  @override
  State<ReadWriteScreen> createState() => _ReadWriteScreenState();
}

class _ReadWriteScreenState extends State<ReadWriteScreen> {
  bool writer = false;bool reader = false;
  List obj = [];
  final user = FirebaseAuth.instance.currentUser ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(backgroundColor: Colors.grey,width: 300,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [

            Center(
              child: Text("                 Hello !!! \n${user?.email}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15
              ),),
            ),
            ElevatedButton(onPressed: (){
              signOut();
            }, child: Text("signout"))
          ],
        ),
      ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Checkbox(value: writer, onChanged: (writer) {
          setState(() {
            this.writer = writer!;
          });
        }), Text("Writer")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(value: reader, onChanged: (reader){
                  setState((){
                    this.reader = reader!;
                  });
                }),
                Text("Reader")
              ],
            ),
            ElevatedButton(onPressed: (){
              if(writer) {
                Navigator.pushNamed(context, 'writer');
              }
              else if(reader){
                Navigator.pushNamed(context, 'reader');
              }
            }, child: Text("Go to"))
          ],
        ),
      )
    );
  }
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    return LoginScreen();
  }
  updateW(bool writer) {
    this.writer = writer;
  }

  updateR(bool reader) {
    this.reader = reader;
  }
}


