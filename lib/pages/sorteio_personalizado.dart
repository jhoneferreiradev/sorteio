import 'package:flutter/material.dart';

import '../main.dart';

class PageSorteioPersonalizado extends StatefulWidget {
  PageSorteioPersonalizado({Key? key}) : super(key: key);

  final String title = "Sorteio Personalizado";
  static String route_name = "page_sorteio_personalizado";
  final String url_gif_fogos_1 =
      "https://img1.picmix.com/output/stamp/normal/7/3/4/1/1061437_714bf.gif";
  final String url_gif_aguarde =
      "https://cdn.dribbble.com/users/765253/screenshots/2540865/loader.gif";

  @override
  State<PageSorteioPersonalizado> createState() =>
      _PageSorteioPersonalizadoState();
}

class _PageSorteioPersonalizadoState extends State<PageSorteioPersonalizado> {
  final TextEditingController edit_nomeOpcao = TextEditingController();
  String textAguarde = "Sorteando uma opção....aguarde...";
  String textoResultadoSorteio = "A opção sorteada é ";
  int indexSorteado = 0;
  bool sorteou = false, sorteando = false;
  List<String> opcoes = ['Opção A', 'Opção B', 'Opção C'];
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      "Sorteio personalizado",
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
                      "Adicione as opções possíveis e faça o seu sorteio. O sorteio será feito com as opções disponíveis!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                    )),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: TextField(
                            controller: edit_nomeOpcao,
                            decoration:
                                InputDecoration(label: Text("Nome da opção")))),
                    Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (edit_nomeOpcao.text.toString().trim().isEmpty) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "É necessário definir um nome para a opção")));
                                return;
                              }

                              if (opcoes.contains(edit_nomeOpcao.text)) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Esta opção já foi adicionaa")));
                                return;
                              }

                              opcoes.add(edit_nomeOpcao.text);
                              edit_nomeOpcao.clear();
                            });
                          },
                          child: Text("Incluir")),
                    )
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(8),
                  constraints: BoxConstraints(
                    maxHeight: 250,
                  ),
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.black,
                              width: 1))),
                  child: SingleChildScrollView(
                    child: ListView(
                      padding: EdgeInsets.all(8),
                      shrinkWrap: true,
                      children: [
                        for (String opcao in opcoes)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(flex: 5, child: Text(opcao)),
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            opcoes.remove(opcao);
                                          });
                                        },
                                        child: Icon(Icons.remove)),
                                  )
                                ],
                              ),
                              SizedBox(height: 8),
                            ],
                          )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                    onPressed: () async {
                      if (opcoes == null ||
                          opcoes.isEmpty ||
                          opcoes.length == 1) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "É necessário ter mais de uma opção para realizar o sorteio")));
                        return;
                      }

                      setState(() {
                        sorteando = true;
                        sorteou = false;
                      });

                      await Future.delayed(Duration(seconds: 2));

                      setState(() {
                        indexSorteado = Util.sortearOpcoes(opcoes);
                        sorteou = true;
                        sorteando = false;
                        scrollController.jumpTo(MediaQuery.of(context).size.height);
                      });
                    },
                    child: Text("Iniciar Sorteio")),
                SizedBox(height: 8),
                if (sorteando)
                  Text(textAguarde,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium),
                if (sorteando)
                  Image.network(widget.url_gif_aguarde, width: 100, height: 100),
                if (sorteou)
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
                              child: Text(textoResultadoSorteio,
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
                            child: Text(opcoes[indexSorteado],
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
