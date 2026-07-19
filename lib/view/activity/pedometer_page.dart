import 'package:flutter/material.dart';

class PedometerPage extends StatefulWidget {
  const PedometerPage({super.key});

  @override
  State<PedometerPage> createState() => PedometerPageState();
}

class PedometerPageState extends State<PedometerPage> {

  @override
  Widget build(BuildContext context){
    return Center(child: Text("Pedometer Page."));
  }
}