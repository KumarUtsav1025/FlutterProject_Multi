import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multil/screens.dart';


class dashboard extends StatefulWidget {
  const dashboard({ Key? key }) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard',style: GoogleFonts.fredokaOne(fontSize: 30,color: Colors.black,),)
      ,backgroundColor: const Color.fromARGB(255, 169, 168, 230),
      foregroundColor: Colors.black,
      automaticallyImplyLeading: false,
      actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
              Navigator.pop(context);
            },
          )
  ],),
      backgroundColor: Colors.black,

      body: Column(
        children: <Widget>[
          const SizedBox(height: 50.0,),
          const Align(alignment: Alignment.center,),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),
              color: const Color.fromARGB(255, 169, 168, 230), 
              ),
              width: 330.0,
              height:180.0,
              child: Row(
                children: [
                  Image.asset('assets/images/HomM.png',fit: BoxFit.fill, height: 180,width: 100,alignment: Alignment.topLeft,),
                  const SizedBox(width: 10,),
                  Column(children: <Widget>[
                    const SizedBox(height:10.0),
                    Text('Welcome',style: GoogleFonts.fredokaOne(fontSize: 35,),),
                    const SizedBox(height: 10.0,),
                    Text(name ,style: GoogleFonts.fredokaOne(fontSize: 25,),textAlign: TextAlign.left,),
                    const SizedBox(height: 10.0,),  
                  ],
                  ),
                ],
              ),
            ),
          const SizedBox(height: 30.0,),
          Text('Services',style: GoogleFonts.fredokaOne(fontSize: 30,color: Colors.white),),
          const SizedBox(height: 20.0,),
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: <Widget>[
              ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, 
                        MaterialPageRoute(builder :(context) => const Notes(),)
                        );
                      },
                      child: const Text('Make Notes',style: TextStyle(fontSize:25.0),),
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all(const Color.fromARGB(255, 169, 168, 230),),
                        padding: MaterialStateProperty.all(const EdgeInsets.only(left:70.0,top:15.0,right:70.0,bottom:15.0)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(color: Color.fromARGB(255, 169, 168, 230),)
                            )
                          )
                        )
                      ),
                      const SizedBox(height: 20.0,),
                      ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, 
                        MaterialPageRoute(builder :(context) => const apiis(),)
                        );
                      },
                      child: const Text('Search Images',style: TextStyle(fontSize:25.0),),
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all(const Color.fromARGB(255, 169, 168, 230),),
                        padding: MaterialStateProperty.all(const EdgeInsets.only(left:70.0,top:15.0,right:70.0,bottom:15.0)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(color: Color.fromARGB(255, 169, 168, 230),)
                            )
                          )
                        )
                      ),
            ],
          )
        ],
      ),
    );
  }
}


class Notes extends StatefulWidget {
  const Notes({ Key? key }) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Note',style: GoogleFonts.fredokaOne(fontSize: 30,),),backgroundColor: const Color.fromARGB(255, 169, 168, 230),foregroundColor: Colors.black,),
      body: Container(
        color: Colors.black,
        child: Text('Under Construction, Soon will be released in upcoming updates',style: GoogleFonts.fredokaOne(fontSize: 30,),), 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Notepop(context);
        },
        backgroundColor: Color.fromARGB(255, 169, 168, 230),
        child: const Icon(Icons.add),
      ),
    );
  }
}


class apiis extends StatefulWidget {
  const apiis({ Key? key }) : super(key: key);

  @override
  State<apiis> createState() => _apiisState();
}

class _apiisState extends State<apiis> {

  List? data;
  String surc='marvel';

  @override
  void initState() {
    super.initState();
    getData(surc);
  }

  Future<String> getData(String surch) async{
    var onlineData = await http.get(Uri.parse('https://api.unsplash.com/search/photos?per_page=30&client_id=TVJfpqhQMJupIVfg6cpV8KXdXshC5Fgcddti4UEZPt0&query=$surch'));
  
    var jdata = jsonDecode(onlineData.body);
    setState(() {
      data=jdata['results'];
    });
    return 'success';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text('Images',style: GoogleFonts.fredokaOne(fontSize: 30,),),
      backgroundColor: const Color.fromARGB(255, 169, 168, 230),
      foregroundColor: Colors.black,
      actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Search'),
                content: TextField(
                      onChanged: (value) {
                        surc=value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Type Here',
                      ),
                    ),
                actions: <Widget>[
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                      setState(() {
                        getData(surc);
                      });
                    },
                    child: const Text('Search'),
                  ),
                ],
              )
              );
            },
          ),
        ],
      ),

      body:ListView.builder(itemCount: data==null? 0 :data?.length,
      itemBuilder: (context,index){
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width*0.95,
              height: MediaQuery.of(context).size.height*0.50,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15,bottom: 15.0),
                child: Image.network(data![index]['urls']['small'],
                fit: BoxFit.cover,
                
                height: 500.0,
                ),
              ),
            ),
          ],
        );
      }
      )
    );
  }
}

void Notepop(context){
  String sub='';
  String desc='';

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
            Text('Add Note', style:GoogleFonts.fredokaOne(color: const Color.fromARGB(255, 255, 255, 255),fontSize: 50.0,),),
            const SizedBox(height: 10.0,),
            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),
              color: Color.fromARGB(255, 169, 168, 230), 
              ),
              padding: const EdgeInsets.only(left:20.0,top:22.0,right:20.0,bottom:10.0),
              width: 300.0,
              height:300.0,
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      sub=value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Subject',
                    ),
                  ),
                  const SizedBox(height: 15.0,),
                  TextField(
                    onChanged: (value) {
                      desc=value;
                    },
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Description',
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text('ADD',style: TextStyle(fontSize:25.0),),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.only(left:70.0,top:15.0,right:70.0,bottom:15.0)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(color: Color.fromARGB(255, 169, 168, 230))
                            )
                          )
                        )
                      ),
                      const SizedBox(height: 8,),
              ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
            const SizedBox(height: 20.0,)
          ],
         ),
      )
      );
});
}