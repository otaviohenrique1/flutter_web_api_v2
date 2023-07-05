import 'dart:math';

asyncStudy() {
  esperandoFuncoesAssincronas();
}

void execucaoNormal() {
  // ignore: avoid_print
  print("\nExecução Normal");
  // ignore: avoid_print
  print("01");
  // ignore: avoid_print
  print("02");
  // ignore: avoid_print
  print("03");
  // ignore: avoid_print
  print("04");
  // ignore: avoid_print
  print("05");
}

void assincronismoBasico() {
  // ignore: avoid_print
  print("\nAssincronismo Básico");
  // ignore: avoid_print
  print("01");
  // ignore: avoid_print
  print("02");
  Future.delayed(const Duration(seconds: 2), () {
    // ignore: avoid_print
    print("03");
  });
  // ignore: avoid_print
  print("04");
  // ignore: avoid_print
  print("05");
}

void usandoFuncoesAssincronas() {
  // ignore: avoid_print
  print("\nUsando funções assíncronas");
  // ignore: avoid_print
  print("A");
  // ignore: avoid_print
  print("B");
  //print(getRandomInt(3)); // Instance of Future<int>
  getRandomInt(3).then((value) {
    // ignore: avoid_print
    print("O número aleatório é $value.");
    // E se eu quiser que as coisas só aconteçam depois?
  });
  // ignore: avoid_print
  print("C");
  // ignore: avoid_print
  print("D");
}

void esperandoFuncoesAssincronas() async {
  // ignore: avoid_print
  print("A");
  // ignore: avoid_print
  print("B");
  int number = await getRandomInt(4);
  // ignore: avoid_print
  print("O outro número aleatório é $number.");
  // ignore: avoid_print
  print("C");
  // ignore: avoid_print
  print("D");
}

Future<int> getRandomInt(int time) async {
  await Future.delayed(Duration(seconds: time));

  Random rng = Random();

  return rng.nextInt(10);
}
