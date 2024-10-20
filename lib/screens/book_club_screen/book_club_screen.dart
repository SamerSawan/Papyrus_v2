import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/core/api/firestore_service.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/helper/helper_functions.dart';
import 'package:papyrus/screens/comment_screen/comment_screen.dart';
import 'package:papyrus/screens/widgets/book_card.dart';
import 'package:papyrus/screens/widgets/book_timeline.dart';
import 'package:papyrus/screens/widgets/custom_button.dart';
import 'package:papyrus/screens/widgets/reading_progress.dart';
import 'package:papyrus/screens/widgets/information_box.dart';
import 'package:papyrus/screens/widgets/description_box.dart';
import 'package:papyrus/screens/widgets/popup_update_progress.dart';

class BookClubScreen extends StatefulWidget {
  final BookClub bookClub;
  final String bookClubID;

  const BookClubScreen(
      {super.key, required this.bookClub, required this.bookClubID});

  @override
  State<BookClubScreen> createState() => _BookClubScreenState();
}

class _BookClubScreenState extends State<BookClubScreen> {
  FirestoreService firestoreService = FirestoreService();
  late BookClub bookClub;

  @override
  void initState() {
    super.initState();
    bookClub = widget.bookClub;
  }

  void _updateProgress() async {
    // Fetch updated data
    final updatedBookClub =
        await firestoreService.fetchBookClubById(widget.bookClubID);
    setState(() {
      bookClub = updatedBookClub!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: PopUpUpdate(
        bookClubID: widget.bookClubID,
        onProgressUpdated: _updateProgress, // Pass the callback
      ),
      body: ListView(
        children: [
          CupertinoNavigationBar(
            middle: Text(
              widget.bookClub.name,
              style: Theme.of(context).textTheme.titleMedium, // changed style
            ),
            trailing: IconButton(
              icon: const Icon(Icons.chat_bubble_outline_rounded),
              onPressed: () => Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => CommentScreen(
                        bookClub: widget.bookClub,
                        bookClubID: widget.bookClubID,
                      ))),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios), // removed grey color
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: const Color(0xFF001A23),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BookCard(
                book: bookClub.currentBook,
              ),
              Align(
                child: SizedBox(
                  width: 367,
                  height: 90,
                  child: Row(
                    children: [
                      DescriptionBox(description: bookClub.description),
                      const InformationBox(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: "Invite User",
                onTap: () {
                  displayInviteUser(context, widget.bookClubID);
                },
              ),
              ReadingProgress(
                bookClub: bookClub,
              ),
              BookTimeline(
                book: bookClub.currentBook,
                bookClubID: widget.bookClubID,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
