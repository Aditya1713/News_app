import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:news_app/screens/Reader.dart';
import 'package:news_app/screens/Witer.dart';
import 'package:news_app/main.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
 

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    bool value = false; bool? writer,reader;
    bool value1 = false;
  final emailController = TextEditingController();
  final passController = TextEditingController(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SignUp"),backgroundColor: Colors.purpleAccent,),
      body: Container(
        color: Colors.purple[200],
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Lottie.network("https://assets1.lottiefiles.com/packages/lf20_3tQA96fr5H.json",fit: BoxFit.fill),
              ),
            ),
            Expanded(flex: 3,
                child: Container(
             decoration: BoxDecoration(color: Colors.white,
              border: Border.all(width: 4),
               borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40),
               ),
             ),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(10,20,10,10),
                        child: TextFormField(
                          controller: emailController,
                        decoration: InputDecoration(fillColor: Colors.yellowAccent,
                          iconColor:Colors.yellowAccent,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(30)
                          )
                          )
                          ,border: OutlineInputBorder(),
                          labelText: "Enter the email",

                        ),
                      ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(10,10,10,10),
                        child: TextFormField(controller: passController,obscureText: true,obscuringCharacter: "~",
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2),borderRadius: BorderRadius.all(Radius.circular(30))
                            ),border: OutlineInputBorder(),
                            labelText: "Enter the password",
                          ),
                        ),
                      ),
           /*         Padding(padding: EdgeInsets.fromLTRB(10,10,10,10),
                      child:  Row(
                        children: [
                          Expanded(child:
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50.0,0,0,0),
                            child: Text("Writer"),
                          )),
                          Checkbox(value: value, onChanged: (value){
                            setState((){
                              this.value = value!;
                              if(value)
                              writer = true;
                            });

                          },),

                          Expanded(child:
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50.0,0,0,0),
                            child: Text("Reader"),
                          )),

                          Checkbox(value: value1, onChanged: (value1){
                            setState((){
                              this.value1 = value1!;
                              if(value1)
                                reader = true;
                            });
                            },)
                        ],
                      ),
                    ),*/

                      Padding(
                        padding: const EdgeInsets.fromLTRB(100,0,0,15),
                        child: Row(
                          children: [
                            SizedBox(width: 20,),
                            MaterialButton(
                                onPressed: signIn,
                                child: Container(width: 100,height: 30,alignment: Alignment.center,
                              child: Text("Sign Up"),decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 2),color: Colors.purpleAccent.withOpacity(0.4)),
                            )
                            ),
                            Text("Or"),
                            IconButton(onPressed: gmailSignIn, icon: Icon(Icons.mail,size: 30,color: Colors.redAccent,))
                          ],
                        ),
                      )

                    ],
                  ),
            )
            )
          ],
        ),
      ),
    );
  }



  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passController.text.trim());
    // User user = FirebaseAuth.instance.currentUser;

       if(writer==true)
         Navigator.pushNamed(context, 'writer');
       else if(reader==true) Navigator.pushNamed(context, 'reader');

   // await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passController.text.trim());
  }

  Future gmailSignIn() async{
    await FirebaseAuth.instance.signInWithProvider(GoogleAuthProvider());
  }
    @override
    void dispose() {
      emailController.dispose();
      passController.dispose();
      super.dispose();
    }

}