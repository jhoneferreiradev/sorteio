import 'package:flutter/material.dart';

import '../main.dart';

class PageSorteioSimples extends StatefulWidget {
  PageSorteioSimples({Key? key}) : super(key: key);

  final String title = "Sorteio Simples";
  static String route_name = "page_sorteio_padrao";
  final String url_gif_fogos_1 =
      "https://img1.picmix.com/output/stamp/normal/7/3/4/1/1061437_714bf.gif";
  final String url_gif_aguarde =
      "https://cdn.dribbble.com/users/765253/screenshots/2540865/loader.gif";

  final TextEditingController edit_numInicial = TextEditingController();
  final TextEditingController edit_numFinal = TextEditingController();
  String textoAguarde = "Gerando o número....aguarde...";
  String textoResultadoSorteio = "O número sorteado é ";
  int numSorteado = 0;
  bool sorteou = false, sorteando = false;

  @override
  State<PageSorteioSimples> createState() => _PageSorteioSimplesState();
}

class _PageSorteioSimplesState extends State<PageSorteioSimples> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      "Sorteio simples",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      "Escolha o número inicial e o número final. O sorteio será feito com número dentro do intervalo escolhido!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                    )),
                  ],
                ),
                SizedBox(height: 100),
                Row(
                  children: [
                    Expanded(flex: 2, child: SizedBox()),
                    Expanded(
                        flex: 2,
                        child: TextField(
                            controller: widget.edit_numInicial,
                            decoration:
                                InputDecoration(label: Text("Nº inicial")))),
                    Expanded(flex: 2, child: SizedBox()),
                    Expanded(
                        flex: 2,
                        child: TextField(
                            controller: widget.edit_numFinal,
                            decoration:
                                InputDecoration(label: Text("Nº final")))),
                    Expanded(flex: 2, child: SizedBox()),
                  ],
                ),
                SizedBox(height: 8),
                ElevatedButton(
                    onPressed: () async {
                      if (widget.edit_numInicial.text.trim().isEmpty ||
                          widget.edit_numFinal.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "É necessário definir um intervalo válido")));
                        return;
                      }

                      int numIni = 0, numFinal = 0;

                      try {
                        numIni = int.parse(widget.edit_numInicial.text);
                        numFinal = int.parse(widget.edit_numFinal.text);
                      } catch (e) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "É necessário definir um intervalo válido")));
                        return;
                      }

                      if (numIni >= numFinal) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "É necessário definir um intervalo válido")));
                        return;
                      }

                      setState(() {
                        widget.sorteou = false;
                        widget.sorteando = true;
                      });

                      await Future.delayed(Duration(seconds: 5));

                      setState(() {
                        widget.numSorteado = Util.sortear(numIni, numFinal);
                        widget.sorteou = true;
                        widget.sorteando = false;
                        scrollController
                            .jumpTo(MediaQuery.of(context).size.height);
                      });
                    },
                    child: Text("Iniciar Sorteio")),
                SizedBox(height: 8),
                if (widget.sorteando)
                  Text(widget.textoAguarde,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium),
                if (widget.sorteando)
                  Image.network(widget.url_gif_aguarde,
                      width: 100, height: 100),
                if (widget.sorteou)
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Image.network(widget.url_gif_fogos_1,
                                  width: 100, height: 100)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(widget.textoResultadoSorteio,
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.titleMedium)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: Image.network(widget.url_gif_fogos_1,
                                  width: 100, height: 100)),
                          Expanded(
                            flex: 4,
                            child: Text(widget.numSorteado.toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                          Expanded(
                              flex: 4,
                              child: Image.network(widget.url_gif_fogos_1,
                                  width: 100, height: 100)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Image.network(widget.url_gif_fogos_1,
                                  width: 100, height: 100)),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
