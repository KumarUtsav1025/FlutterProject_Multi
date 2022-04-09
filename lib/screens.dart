import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:multil/dashboard.dart';

String name='User';

class Welcome extends StatefulWidget {
  const Welcome({ Key? key }) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            const SizedBox(height: 100.0,),
            const Align(alignment: Alignment.center,),
            Container(
              width: MediaQuery.of(context).size.width*0.8,
              child: Image.asset('assets/images/HOme.png',)),
            const SizedBox(height: 20.0,),
            Text('Welcome', style:GoogleFonts.fredokaOne(color: const Color.fromARGB(255, 255, 255, 255),fontSize: 50.0,),),

            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),
              color: const Color.fromARGB(255, 34, 33, 32), 
              ),
              padding: const EdgeInsets.only(left:20.0,top:35.0,right:20.0,bottom:50.0),
              width: 300.0,
              height:330.0,
              child: Column(
                children: <Widget>[
                  const Text('My first Multi-Utility App',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 23.0,),),
                  const SizedBox(height: 40.0,),
                  ElevatedButton(
                      onPressed: (){
                        SignupPopup(context);
                      },
                      child: const Text('REGISTER',style: TextStyle(fontSize:25.0),),
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all(const Color.fromARGB(255, 255, 163, 50)),
                        padding: MaterialStateProperty.all(const EdgeInsets.only(left:70.0,top:15.0,right:70.0,bottom:15.0)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(color: Color.fromARGB(255, 255, 163, 50))
                            )
                          )
                        )
                      ),
                  const SizedBox(height: 40.0,),
                  ElevatedButton(
                      onPressed: (){
                        LoginPopup(context);
                      },
                      child: const Text('LOGIN',style: TextStyle(fontSize:25.0),),
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all(const Color.fromARGB(255, 255, 163, 50)),
                        padding: MaterialStateProperty.all(const EdgeInsets.only(left:70.0,top:15.0,right:70.0,bottom:15.0)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(color: Color.fromARGB(255, 255, 163, 50))
                            )
                          )
                        )
                      ),
              ],
              )
              
            )
          ]
         )  
      );
  }
}


// ignore: non_constant_identifier_names
void LoginPopup(context){
    String mail='';
    String pass='';

    showModalBottomSheet<dynamic>(isScrollControlled: true,context: context, builder: (BuildContext bc){
      return Container(
        color: Colors.black,
        child: SingleChildScrollView(
        reverse: true,
          child:Column(
            children: <Widget>[
              const SizedBox(height: 20.0,),
              const Align(alignment: Alignment.center,),
              Text('LOGIN', style:GoogleFonts.fredokaOne(color: const Color.fromARGB(255, 255, 255, 255),fontSize: 50.0,),),
              const SizedBox(height: 10.0,),
              Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),
                color: const Color.fromARGB(255, 239, 192, 159), 
                ),
                padding: const EdgeInsets.only(left:20.0,top:35.0,right:20.0,bottom:30.0),
                width: 300.0,
                height:330.0,
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15.0,),
                    TextField(
                      onChanged: (value) {
                        mail=value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    TextField(
                      onChanged: (value) {
                        pass=value;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    ElevatedButton(
                        onPressed: ()async{
                        try {
                            UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: mail,
                              password: pass
                            );
                            showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Hurray'),
                            content: const Text('You have logged in'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.push(context, 
                                  MaterialPageRoute(builder :(context) => const dashboard(),)
                                  );
                                },
                                child: const Text('Okay'),
                              ),
                            ],
                          )
                          );
                          } on FirebaseAuthException catch (e) {
                            String err = e.code;
                             showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Error'),
                                content: Text(err),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Okay'),
                                  ),
                                ],
                              )
                              );
                          }  
                        },
                        child: const Text('Login',style: TextStyle(fontSize:25.0,color: Colors.black),),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(const EdgeInsets.only(left:70.0,top:15.0,right:70.0,bottom:15.0)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: const BorderSide(color: Colors.white)
                              )
                            )
                          )
                        ),
                        const SizedBox(height: 8,),
                        RichText(
                          text:  TextSpan(
                          children: <TextSpan>[
                            const TextSpan(text: "Don't have an account,", style: TextStyle(fontSize: 14.0, color: Colors.black),),
                            TextSpan(text: ' Sign Up ', 
                            style: const TextStyle(fontSize: 14.0, color: Colors.lightBlue),
                            recognizer: TapGestureRecognizer()
                            ..onTap=(){
                              Navigator.of(context).pop();
                              SignupPopup(context);
                              },
                            ),
                          ]
                        ),
                    ),
                ],
                )
                
              ),
              Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
            ]
           )
        ),
      );
    });
}


void SignupPopup(context){
  String mail='';
  String pass='';

  showModalBottomSheet<dynamic>(isScrollControlled: true,context: context, builder: (BuildContext bc){
      return Container(
        color: Colors.black,
        child: SingleChildScrollView(
        reverse: true,
        child:Column(
          children: <Widget>[
            const SizedBox(height: 2.0,),
            const SizedBox(height: 10.0,),
            const Align(alignment: Alignment.center,),
            Text('SIGNUP', style:GoogleFonts.fredokaOne(color: const Color.fromARGB(255, 255, 255, 255),fontSize: 50.0,),),
            const SizedBox(height: 10.0,),
            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),
              color: const Color.fromARGB(255, 239, 192, 159), 
              ),
              padding: const EdgeInsets.only(left:20.0,top:22.0,right:20.0,bottom:10.0),
              width: 300.0,
              height:350.0,
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[

                  TextField(
                    onChanged: (value) {
                      name=value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                    ),
                  ),
                  const SizedBox(height: 15.0,),
                  TextField(
                    onChanged: (value) {
                      mail=value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 15.0,),
                  TextField(
                    onChanged: (value) {
                      pass=value;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 15.0,),
                  ElevatedButton(
                      onPressed: () async{
                      try {
                        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: mail,
                          password: pass
                        );
                        showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Registered'),
                          content: const Text('You have successfully created account'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Okay'),
                            ),
                          ],
                        )
                        );
                      } on FirebaseAuthException catch (e) {
                        String err=e.code;
                        showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Error'),
                          // ignore: unnecessary_string_interpolations
                          content: Text('$err'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child: const Text('Okay'),
                            ),
                          ],
                        )
                        );
                      } catch (e) {
                        print(e);
                      }
                      },
                      child: const Text('Register',style: TextStyle(fontSize:25.0),),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.only(left:70.0,top:15.0,right:70.0,bottom:15.0)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(color: Colors.blueAccent)
                            )
                          )
                        )
                      ),
                      const SizedBox(height: 8,),
                      RichText(
                        text:  TextSpan(
                        children: <TextSpan>[
                          const TextSpan(text: 'Already have an account, ', style: TextStyle(fontSize: 14.0, color: Colors.black),),
                          TextSpan(text: ' Sign In ', 
                          style: const TextStyle(fontSize: 14.0, color: Colors.lightBlue),
                          recognizer: TapGestureRecognizer()
                          ..onTap=(){
                            Navigator.of(context).pop();
                            LoginPopup(context);
                          },
                          ),]
                      ),
                  ),
              ],
              ),
              
            ),
            Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
          ],
         ),
      )
      );
});
}

