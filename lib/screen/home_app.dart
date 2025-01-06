import 'package:flutter/material.dart';
import 'package:flutter_calculadora_impostos/screen/compound_interest_calculator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home App'),)
      ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:  (context) => CalculadoraJC() ))  ;
            },
            child: Text('Calculadora Juros Compostos'),
            )
          ],
        ),
      ),
    );
  }
}