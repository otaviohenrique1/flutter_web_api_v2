import 'package:flutter/material.dart';
// import 'package:flutter_web_api_v2/database/database.dart';
import 'package:flutter_web_api_v2/models/journal.dart';
import 'package:flutter_web_api_v2/screens/home_screen/widgets/home_screen_list.dart';
import 'package:flutter_web_api_v2/services/journal_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // O último dia apresentado na lista
  DateTime currentDay = DateTime.now();

  // Tamanho da lista
  int windowPage = 10;

  // A base de dados mostrada na lista
  Map<String, Journal> database = {};

  final ScrollController _listScrollController = ScrollController();

  JournalService service = JournalService();

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Título basado no dia atual
        title: Text(
          "${currentDay.day}  |  ${currentDay.month}  |  ${currentDay.year}",
        ),
        actions: [
          IconButton(
            onPressed: () {
              refresh();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: ListView(
        controller: _listScrollController,
        children: generateListJournalCards(
          refreshFunction: refresh,
          windowPage: windowPage,
          currentDay: currentDay,
          database: database,
        ),
      ),
    );
  }

  void refresh() async {
    List<Journal> listJournal = await service.getAll();
    setState(() {
      database = {};
      for (Journal journal in listJournal) {
        database[journal.id] = journal;
      }
      // database = generateRandomDatabase(maxGap: windowPage, amount: 3);
    });
  }
}
