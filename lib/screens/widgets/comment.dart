import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget{
  const CommentBox ({super.key});
  
  @override
  Widget build(context) {
    return Container(
                padding: const EdgeInsets.all(10),
                width: 367,
                height: 116,
                color: Theme.of(context).colorScheme.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          radius: 15,
                          child: const Text('JC'),
                          ),
                        const SizedBox(width: 5),
                        const Text(
                          '[User] is [x] % through. ',
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      '[Comment]',
                        ),
                    const Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.chat_bubble_outline_rounded, // need to change icon i dont like this one lol
                            )),
                      ],
                    )
                  ],
                ),
              );
  }
}