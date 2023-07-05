import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_web_api_v2/helpers/logout.dart';
import 'package:flutter_web_api_v2/helpers/weekday.dart';
import 'package:flutter_web_api_v2/models/journal.dart';
import 'package:flutter_web_api_v2/screens/commom/exception_dialog.dart';
import 'package:flutter_web_api_v2/services/journal_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddJournalScreen extends StatelessWidget {
  AddJournalScreen({
    super.key,
    required this.journal,
    required this.isEditing,
  });

  final Journal journal;
  final bool isEditing;
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _contentController.text = journal.content;

    return Scaffold(
      appBar: AppBar(
        title: Text(WeekDay(journal.createdAt).toString()),
        actions: [
          IconButton(
            onPressed: () {
              registerJournal(context);
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _contentController,
          keyboardType: TextInputType.multiline,
          style: const TextStyle(fontSize: 24),
          expands: true,
          minLines: null,
          maxLines: null,
        ),
      ),
    );
  }

  void registerJournal(BuildContext context) {
    SharedPreferences.getInstance().then(
      (prefs) {
        String? token = prefs.getString("accessToken");

        if (token != null) {
          String content = _contentController.text;

          journal.content = content;

          JournalService service = JournalService();

          if (isEditing) {
            service.register(journal, token).then((value) {
              Navigator.pop(context, value);
            });
          } else {
            service.edit(journal.id, journal, token).then((value) {
              Navigator.pop(context, value);
            });
          }
        }
      },
    ).catchError(
      (error) {
        logout(context);
      },
      test: (error) => error is TokenNotValidException,
    ).catchError(
      (error) {
        var innerError = error as HttpException;
        showExceptionDialog(context, content: innerError.message);
      },
      test: (error) => error is HttpException,
    );
  }
}
