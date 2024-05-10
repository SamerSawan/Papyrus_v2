import 'package:flutter/material.dart';
import 'package:papyrus/core/api/firestore_service.dart';
import 'package:papyrus/core/models/book_club.dart';

class NotificationsScreen extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitations'),
      ),
      body: FutureBuilder<List<BookClub>>(
        future: firestoreService.getInvites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<BookClub> invitations = snapshot.data!;
            if (invitations.isEmpty) {
              return const Center(
                child: Text('No invitations'),
              );
            } else {
              return ListView.builder(
                itemCount: invitations.length,
                itemBuilder: (context, index) {
                  BookClub bookClub = invitations[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          bookClub.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(bookClub.description),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Accept invite action
                                _acceptInvite(bookClub);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green),
                              ),
                              child: Text('Accept invite'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Reject invite action
                                _rejectInvite(bookClub);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                              ),
                              child: Text('Reject invite'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(
              child: Text('No data'),
            );
          }
        },
      ),
    );
  }
}

void _rejectInvite(BookClub bookClub) {}

void _acceptInvite(BookClub bookClub) {}
