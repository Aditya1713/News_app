import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class WriterScreen extends StatefulWidget {
  const WriterScreen({Key? key}) : super(key: key);

  @override
  State<WriterScreen> createState() => _WriterScreenState();
}

class _WriterScreenState extends State<WriterScreen> {
  String? url;
  final titleController  = TextEditingController();
  final priceController  = TextEditingController();
  final disPriceController  = TextEditingController();
  File? file1;
  Future getImage(int n) async{
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(image==null )return;

    setState(() {
      this.file1 = File(image.path);
    });
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("Article"),
       backgroundColor: Colors.grey[500],),
     body: Container(
       decoration: BoxDecoration(
         border: Border.all(color: Colors.black87,width: 2),
         color: Colors.grey[300],
       ),
       child: Padding(
         padding: const EdgeInsets.fromLTRB(20.0,20,20,0),
         child: 
         Column(
           children: [
             Expanded(

               child: Center(
                 child: SingleChildScrollView(
                   scrollDirection: Axis.vertical,
                   child:
                   Container(
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.grey,width: 2),
                       borderRadius: BorderRadius.circular(10),
                       color: Colors.white,
                     ),
                     child: Padding(
                       padding: const EdgeInsets.fromLTRB(20.0,20,20,20),
                       child: Column(
                         children: [
                           Container(
                             decoration: BoxDecoration(
                               border: Border.all(color: Colors.grey,width: 2),
                               borderRadius: BorderRadius.circular(10),

                             ),
                             child: file1!=null ? Image.file(File(file1!.path),width: 100 ,height: 150): Icon(Icons.image_search_outlined,size: 100,),
                           ),

                           IconButton(onPressed: () {
                             getImage(1);},
                               icon: Icon(Icons.add,color: Colors.black87)
                           ),
                           SizedBox(height: 20,),
                           TextFormField(
                             controller: titleController,
                             decoration: InputDecoration(

                               enabledBorder: OutlineInputBorder(
                                   borderSide: BorderSide(width: 2),borderRadius: BorderRadius.all(Radius.circular(30))
                               ),border: OutlineInputBorder(),
                               labelText: "Enter the title",
                             ),
                           ),SizedBox(height: 20,),

                           TextFormField(
                             controller: priceController,
                             decoration: InputDecoration(
                               enabledBorder: OutlineInputBorder(
                                   borderSide: BorderSide(width: 2),borderRadius: BorderRadius.all(Radius.circular(30))
                               ),border: OutlineInputBorder(),
                               labelText: "Enter the price",
                             ),
                           ),
                           SizedBox(height: 20,),
                           TextFormField(
                             controller: disPriceController,
                             decoration: InputDecoration(
                               enabledBorder: OutlineInputBorder(
                                   borderSide: BorderSide(width: 2),borderRadius: BorderRadius.all(Radius.circular(30))
                               ),border: OutlineInputBorder(),
                               labelText: "Enter the discounted price",
                             ),
                           ),
                           SizedBox(height: 20,),
                           ElevatedButton(onPressed: (){
                             upload(file1!);
                           }, child: Text("Update data"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey[500]),shadowColor: MaterialStateProperty.all(Colors.black)),)
                         ],
                       ),
                     ),
                   ),
                 ),
               ),
             ),
           ],
         ),
       ) ,
     ),
   );
  }

  Future upload(File file) async{
    final storageRef = FirebaseStorage.instance.ref();
    Reference ref = storageRef.child('pictures/${DateTime.now().millisecond}.jpeg');
    final uploadTask = ref.putFile(file);
    final taskSnapshot = await uploadTask.whenComplete(() => null);
    url = await taskSnapshot.ref.getDownloadURL();
    CollectionReference<Map<String, dynamic>> reference = FirebaseFirestore.instance.collection("Articles");
          reference.add({
            'title': titleController.text.trim(),
            'price': priceController.text.trim(),
            'disPrice': disPriceController.text.trim(),
            'img':url
          });
  }
}
