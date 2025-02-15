import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // [INFO]: remove debug banner on top-right
      home: ResponsiveListScreen(),
    );
  }
}

class ResponsiveListScreen extends StatelessWidget {
  final numbers = List.generate(20, (index) => index + 1); // [INFO]: generate a list of 20 numbers (e.g. 1-20)

  ResponsiveListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive List')),
      body: buildResponsiveListView(isPortrait), // [INFO]: build a list or grid view based on orientation of the device
    );
  }

  Widget buildResponsiveListView(bool isPortrait) {
    return isPortrait
        ? ListView.builder(
            itemCount: numbers.length,
            itemBuilder: (context, index) => NumberTile(number: numbers[index]), // [INFO]: create a list of NumberTile widgets
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // [INFO]: set 2 columns in landscape
              childAspectRatio: 3, // [INFO]: adjust size of each tile
            ),
            itemCount: numbers.length,
            itemBuilder: (context, index) => NumberTile(number: numbers[index]),
          );
  }
}

class NumberTile extends StatelessWidget { // [INFO]: build a tile widget that displays a number followed by the 'Item'
  final int number;

  const NumberTile({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(child: Text(number.toString())),
        title: Text('Item $number'),
      ),
    );
  }
}
