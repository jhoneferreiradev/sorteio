import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sorteio/app_routes.dart';
import 'package:sorteio/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sorteio App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.initial,
      routes: AppRoutes.routes,
    );
  }
}

class Util {
  static int sortear(int numIni, int numFinal) {
    int numSorteado = Random().nextInt(numFinal);
    return (numSorteado < numIni) ? sortear(numIni, numFinal) : numSorteado;
  }

  static int sortearOpcoes(List<String> opcoes) {
    int numIni = 0, numFinal = (opcoes.length -1);
    return sortear(numIni, numFinal);
  }
}
