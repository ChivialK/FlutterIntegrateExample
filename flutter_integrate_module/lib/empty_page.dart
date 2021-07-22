import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.black38,
          child: Text(
            "EmptyPage",
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () => AutoRouter.of(context).popUntilRoot(),
          tooltip: 'back',
          child: Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
