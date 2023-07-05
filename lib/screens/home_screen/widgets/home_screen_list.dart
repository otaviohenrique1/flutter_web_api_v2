import 'package:flutter_web_api_v2/models/journal.dart';
import 'package:flutter_web_api_v2/screens/home_screen/widgets/journal_card.dart';

List<JournalCard> generateListJournalCards({
  required int windowPage,
  required DateTime currentDay,
  required Map<String, Journal> database,
  required Function refreshFunction,
  required int userId,
  required String token,
}) {
  // Cria uma lista de Cards vazios
  List<JournalCard> list = List.generate(
    windowPage + 1,
    (index) => JournalCard(
      refreshFunction: refreshFunction,
      showedDate: currentDay.subtract(Duration(days: (windowPage) - index)),
      userId: userId,
      token: token,
    ),
  );

  //Preenche os espaços que possuem entradas no banco
  database.forEach((key, value) {
    if (value.createdAt
        .isAfter(currentDay.subtract(Duration(days: windowPage)))) {
      int difference = value.createdAt
          .difference(currentDay.subtract(Duration(days: windowPage)))
          .inDays
          .abs();

      list[difference] = JournalCard(
        refreshFunction: refreshFunction,
        showedDate: list[difference].showedDate,
        journal: value,
        userId: userId,
        token: token,
      );
    }
  });
  return list;
}
