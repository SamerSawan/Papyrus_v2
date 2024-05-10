import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:papyrus/firebase_options.dart";

class ProfileWidget extends StatefulWidget {  
  const ProfileWidget ({super.key, required this.username});
  final String username;
  
  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(context) {
   return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              // profile picture (needs to be customizable as well)
              CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.secondary,
                              radius: 35,
                              child: const Text('JC'),
                              ),
              const SizedBox(width: 20),
      
              // display name + username
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Joanna', style: Theme.of(context).textTheme.bodyLarge,), // need to add customizable display name 
                  Text('@${widget.username}', style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
              const SizedBox(width: 180),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              SizedBox(width: 20),
              Text('description', textAlign: TextAlign.left,),
            ],
          ),      
      ],),
    
   );
  }
}



