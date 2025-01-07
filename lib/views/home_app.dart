import 'package:flutter/material.dart';
import 'package:flutter_calculadora_impostos/views/compound_interest_calculator.dart';
import 'package:flutter_calculadora_impostos/views/testapi.dart';

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
            ) ,
            MaterialButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:  (context) => DatePickerExample() ))  ;
            },
            child: Text('Correção de valores'),
            ) 
          ],
        ),
      ),
    );
  }
}