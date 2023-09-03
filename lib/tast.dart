



import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logo/models/messages_model.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream collectionStream = FirebaseFirestore.instance
      .collection('users').orderBy('msn',descending: true).snapshots();



  CollectionReference messages =
  FirebaseFirestore.instance.collection("users");
  List<MessagesModel> messagesList = [];

  @override
  Widget build(BuildContext context) {
    return   Scaffold(

      appBar: AppBar(),
      body: StreamBuilder(
        stream: collectionStream,
        builder: (context, snapshot) {
           if(snapshot.hasError){
            return Text("error") ;
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Text("Loading....");
          }
          if(snapshot.hasData){
            messagesList = [] ;
            snapshot.data!.docs.forEach((element) {
              messagesList.add(MessagesModel.fromJson(element.data()));


            });
            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text("${snapshot.data!.docs[index].data()['text'] }"),
                    TextButton(
                        onPressed: () {

                          FirebaseFirestore.instance.collection('users').add({
                            'text': 'Hello11',
                            'msn': FieldValue.serverTimestamp(),
                          });

                        },
                        child: Text("mahmoud"))
                  ],
                );
              },
              itemCount: snapshot.data!.docs.length,
            );
          }
       return Text("mahmoud");
        }
        ,
      )

    );
  }
}
