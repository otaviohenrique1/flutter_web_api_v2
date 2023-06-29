import 'package:flutter/material.dart';
import 'package:flutter_web_api_v2/helpers/weekday.dart';
import 'package:flutter_web_api_v2/models/journal.dart';
import 'package:flutter_web_api_v2/services/journal_service.dart';

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
    String content = _contentController.text;
    journal.content = content;
    JournalService service = JournalService();
    service.register(journal).then((value) {
      Navigator.pop(context, value);
    });
  }

  /*
  void registerJournal(BuildContext context) async {
    String content = _contentController.text;
    journal.content = content;
    JournalService service = JournalService();
    bool result = await service.register(journal);
    Navigator.pop(context, result);
  }
  */
}
