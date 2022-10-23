// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  var contador =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stateless vs Stateful',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
          child: Text('Contador $contador',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          contador++;
          print(contador);
          setState(() {
            
          });
        },
        child: Icon(Icons.ads_click, color: Colors.black,),
        backgroundColor: Colors.yellow,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
