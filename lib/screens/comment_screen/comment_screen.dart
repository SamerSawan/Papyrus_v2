import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:papyrus/core/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:papyrus/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/screens/widgets/comment.dart';
import 'package:papyrus/theme/dark_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      darkTheme: darkMode,
      home: const Scaffold(
        body: Center(
          child: CommentScreen(),
        ),
      ),
    ),
  );
}

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});
  
  @override
  State<StatefulWidget> createState() => _CommmentScreenState();
}

class _CommmentScreenState extends State<CommentScreen> {

final FirestoreService firestoreService = FirestoreService();

final _numberToMonthMap = {
  1: "Jan",
  2: "Feb",
  3: "Mar",
  4: "Apr", 
  5: "May",
  6: "Jun",
  7: "Jul",
  8: "Aug",
  9: "Sep",
  10: "Oct",
  11: "Nov",
  12: "Dec",
};

  @override
  Widget build(context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
                    middle: Text('Comments',
                      style: Theme.of(context).textTheme.titleMedium),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop()
                  ),
                  backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                  ),
      body: StreamBuilder<QuerySnapshot>(
              stream: firestoreService.getCommentsStream(),
              builder: (context, snapshot){
              if (snapshot.hasData){
              List commentsList = snapshot.data!.docs;
        
              return ListView.builder(
                itemExtent: 125,
                itemCount: commentsList.length,
                itemBuilder: (context, index){
                DocumentSnapshot document = commentsList[index];
                String docID = document.id;
        
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String commentText = data['comment'];
                Timestamp t = data['timestamp'] as Timestamp;
                DateTime date = t.toDate();
        
                return  
                  ListTile(
                    title: CommentBox(
                      comment: commentText, 
                      timestamp: Text(
                        '${_numberToMonthMap[date.month]} ${date.day} ${date.year}',
                        style: Theme.of(context).textTheme.labelSmall,)),
                    );
              });
            } else {
              return const Text('No comments yet');
            }
          }
        ),
      );
  }
}


/*
 child: ListView(
          children: [
            CupertinoNavigationBar(
              middle: Text('Comments',
                style: Theme.of(context).textTheme.titleMedium,),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop()
                  ),
                  backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                  ),
            const SizedBox(
              height: 20,
            ),
            const Column(
              children: [
                CommentBox(),
              ],
            )     
          ]),
*/