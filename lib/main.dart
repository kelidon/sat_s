import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'animatedList.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

Logger log = new Logger();
void main() {
  log.i('START ');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SatS',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'SatS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static Widget listScreen = ListScreen();
  static List<Widget> _widgetOptions = <Widget>[
    Text('home', style: optionStyle),
    listScreen,
    Text('observing', style: optionStyle),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.cubes),
            title: Text("Satellites"),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.eye),
            title: Text("Observing"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),

    );
  }
}

