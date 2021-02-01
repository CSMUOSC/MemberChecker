import 'package:flutter/material.dart';
import 'package:barras/barras.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '開源社社員驗證軟體'),
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
  String titleText = "Waiting";

  String checkUser(String _Id){
    //Test data
    Map<String, String> userData = {
      "0770012":"幹部"
    };

    if(!userData.containsKey(_Id)){
      return "非社員";
    }
    else{
      return userData[_Id];
    }
  }
  void _scanBarCode() {
    setState(() {
      Barras.scan(
        context,
        viewfinderHeight: 120,
        viewfinderWidth: 300,
        scrimColor: Color.fromRGBO(128, 0, 0, 0.5),
        borderColor: Colors.red,
        borderRadius: 24,
        borderStrokeWidth: 2,
        buttonColor: Colors.yellow,
        borderFlashDuration: 250,
        cancelButtonText: "取消",
        successBeep: false,
      ).then((String res) {
        setState(() {
          if(res == null){
            titleText = "Cancelled";
          }else{
            titleText = res;
          }

        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '資料庫查詢結果',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$titleText' + ' / ',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  checkUser(titleText),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanBarCode,
        tooltip: 'Scan barcode',
        child: Icon(Icons.linked_camera_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
