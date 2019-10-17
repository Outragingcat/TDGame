import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: App(),
      ),
    );
  }
}

class App extends StatefulWidget{
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  Color caughtColor = Colors.grey;
  var placePosX = [0.0, 75.0, 150.0, 225.0, 300.0];
  var placePosY = [375.0, 300.0, 225.0, 150.0];

  @override
  Widget build (BuildContext context) {
    return Stack(
      children: <Widget>[
        DragTower(Offset(10.0, 0.0), 'Fire Tower', Colors.red),
        DragTower(Offset(95.0, 0.0), 'Water Tower', Colors.blue),
        for (int i = 0; i < 3; i++)
          TowerPos(Offset(placePosX[i], 300)),
        for (int j = 0; j < 5; j++)
          TowerPos(Offset(placePosX[j], 450)),
        for (int k = 0; k < 4; k++)
          TowerPos(Offset(300, placePosY[k])),
        for (int l = 2; l < 4; l++)
          TowerPos(Offset(150, placePosY[l])),
      ],
    );
  }
}

class TowerPos extends StatefulWidget{
  final Offset initPos;
  //final Color towerColor;

  TowerPos(this.initPos);

  @override
  TowerState createState() => TowerState();
}

class TowerState extends State<TowerPos>{
  Offset pos = Offset(0.0, 0.0);
  Color caughtColor = Colors.grey;
  String tower = "";
  bool pressed = false;

  @override
  void initState() {
    super.initState();
    pos = widget.initPos;
  }

  void _showMenu() {
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: pos.dx,
      bottom: pos.dy,
      child: DragTarget(
        onAccept: (Color color){
          caughtColor = color;
          if (color == Colors.red)
            tower = "Fire Tower";
          else if (color == Colors.blue)
            tower = "Water Tower";
        },
        builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
            ){
          return InkWell(
            onDoubleTap: () {
              _showMenu();
              print ("Test");
            },
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: accepted.isEmpty ? caughtColor : Colors.grey.shade100,
              ),
              child: Center (
                child: Text(
                  tower
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DragTower extends StatefulWidget{
  final Offset initPos;
  final String towerName;
  final Color towerColor;

  DragTower(this.initPos, this.towerName, this.towerColor);

  @override
  DragTowerState createState() => DragTowerState();
}

class DragTowerState extends State<DragTower>{
  Offset pos = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    pos = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: pos.dx,
      bottom: pos.dy,
      child: Draggable(
        data: widget.towerColor,
        child: Container(
          width: 75,
          height: 75,
          color: widget.towerColor,
          child: Center(
            child: Text(
              widget.towerName,
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 10.0,
              ),
            ),
          ),
        ),
        feedback: Container(
          width: 50,
          height: 50,
          color: widget.towerColor.withOpacity(0.5),
          child: Center(
            child: Text(
              widget.towerName,
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 10.0,
             ),
            ),
          ),
        ),
      )
    );
  }
}