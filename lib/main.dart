import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 46.0, 8.0, 46.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                child: Text('Material'),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MaterialPage(),
                    )),
              ),
              RaisedButton(
                child: Text('Cupertino'),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CupertinoPage(),
                    )),
              ),
              RaisedButton(
                child: Text('Raw'),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RawPage(),
                    )),
              ),
              Text(
                '${Platform.version}',
                style: Theme.of(context).textTheme.body1,
              )
            ]),
      ),
    );
  }
}

abstract class CommonPage {
  final _verifyController = TextEditingController();

  Widget buildInput(BuildContext context) {
    var textField = TextField(
      controller: _verifyController,
      maxLength: 6,
      maxLengthEnforced: true,
      autocorrect: false,
      autofocus: true,
      decoration: null,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.display1,
    );

    if (context.widget is! Material &&
        context.ancestorWidgetOfExactType(Material) == null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          child: textField,
          type: MaterialType.canvas,
          color: CupertinoColors.white,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: textField,
    );
  }

  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CupertinoButton(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Text(
                'Top label',
                style: Theme.of(context).textTheme.display1.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
          buildInput(context),
        ],
      ),
    );
  }
}

class MaterialPage extends StatefulWidget {
  @override
  _MaterialPageState createState() => _MaterialPageState();
}

class _MaterialPageState extends State<MaterialPage> with CommonPage {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material'),
      ),
      backgroundColor: Colors.lightBlue,
      body: buildBody(context),
    );
  }
}

class CupertinoPage extends StatefulWidget {
  @override
  _CupertinoPageState createState() => _CupertinoPageState();
}

class _CupertinoPageState extends State<CupertinoPage> with CommonPage {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.white30,
          middle: Text('Cupertino'),
        ),
        backgroundColor: Colors.green,
        child: buildBody(context));
  }
}

class RawPage extends StatefulWidget {
  @override
  _RawPageState createState() => _RawPageState();
}

class _RawPageState extends State<RawPage> with CommonPage {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final EdgeInsets minInsets = mediaQuery.padding.copyWith(
      bottom: mediaQuery.viewInsets.bottom,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.deepOrange,
      ),
      child: Padding(
        padding: minInsets,
        child: Container(
          child: buildBody(context),
        ),
      ),
    );
  }
}
