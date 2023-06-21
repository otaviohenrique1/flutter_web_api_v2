import 'dart:math';
import 'package:uuid/uuid.dart';
import 'package:flutter_web_api_v2/models/journal.dart';
import 'package:flutter_web_api_v2/helpers/phrases.dart';

Map<String, Journal> generateRandomDatabase({
  required int maxGap, // Tamanho máximo da janela de tempo
  required int amount, // Entradas geradas
}) {
  Random rng = Random();

  Map<String, Journal> map = {};

  for (int i = 0; i < amount; i++) {
    int timeGap = rng.nextInt(maxGap - 1); // Define uma distância do hoje
    DateTime date = DateTime.now().subtract(
      Duration(days: timeGap),
    ); // Gera um dia

    String id = const Uuid().v1();

    map[id] = Journal(
      id: id,
      content: getRandomPhrase(),
      createdAt: date,
      updatedAt: date,
    );
  }
  return map;
}
