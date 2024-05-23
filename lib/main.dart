import 'package:flutter/material.dart';
import 'package:flutter42/wievs/screens/plan_wiecs.dart';
import 'package:provider/provider.dart';
import 'controllaers/plans_controller.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlanController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rejalar',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PlanView(),
      ),
    );
  }
}
