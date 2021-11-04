import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_integrate_module/channel_util.dart';

import 'app_router.gr.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: appRouter.delegate(
        navigatorObservers: () => <NavigatorObserver>[
          AutoRouteObserver(),
        ],
      ),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _native = '來自MethodChannel的訊息';
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    ChannelUtil.sendAsMethod('$_counter');
  }

  /// update [_native] text when received message from [ChannelUtil]
  Future<dynamic> onReceivedMethodMessage(dynamic msg) {
    setState(() {
      _native = msg.toString();
    });
    if (msg == 'back') {
      final canPop = context.router.canPopSelfOrChildren;
      final returnMsg = (canPop) ? '' : 'exit';
      debugPrint('received message from native: $msg');
      debugPrint('flutter will return message: $returnMsg');
      if (canPop) {
        Future.delayed(Duration(milliseconds: 100), () => context.router.pop());
      } else {
        ChannelUtil.sendAsMethod(returnMsg);
        // return null to dispose message handler
        return Future.value(null);
      }
    }
    return Future.value('');
  }

  /// update [_native] text when received message from [ChannelUtil]
  Future<String> onReceivedBasicMessage(String? msg) {
    setState(() {
      _native = msg.toString();
    });
    return Future.value('');
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Integrated Flutter"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: GestureDetector(
                onTap: () => ChannelUtil.start(
                  onReceivedMethod: onReceivedMethodMessage,
                  onReceivedBasic: onReceivedBasicMessage,
                ),
                child: Text(
                  "檢查通道並綁定 Flutter 端訊息通知介面",
                  style: TextStyle(fontSize: 14.0, color: Colors.indigo),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                _native,
                style: TextStyle(fontSize: 20.0, color: Colors.teal),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: StreamBuilder(
                stream: ChannelUtil.startStream(),
                initialData: '',
                builder: (_, snapshot) {
                  return GestureDetector(
                    onTap: () => ChannelUtil.sendAsBasic('reset'),
                    child: Text(
                      "event: ${snapshot.data}",
                      style: TextStyle(
                          fontSize: 20.0, color: Colors.deepOrangeAccent),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: GestureDetector(
                onTap: () => context.router.push(EmptyRoute()),
                child: Text(
                  "開啟 Flutter 內頁",
                  style: TextStyle(fontSize: 14.0, color: Colors.deepPurple),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
