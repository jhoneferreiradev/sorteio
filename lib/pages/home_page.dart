import 'package:flutter/material.dart';
import 'package:sorteio/app_routes.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  final String title = "Sorteio App";

  static String route_name = "page_home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    "Faça Seu Sorteio",
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
                    "Escolha o modo de sorteio preferido e conheça os vencedores!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
                ],
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          AppRoutes.goToPageSorteioSimples(context);
                        },
                        child: Text("Sorteio Simples")),
                  )),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          AppRoutes.goToPageSorteioPersonalizado(context);
                        },
                        child: Text("Sorteio Personalizado")),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
