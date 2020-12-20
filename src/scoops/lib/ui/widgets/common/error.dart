import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView(this._errorMessage, {this.refreshCallback, Key key})
      : super(key: key);
  final String _errorMessage;
  final Function refreshCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.warning_rounded,
          color: Colors.red,
          size: 50,
        ),
        Center(
            child: Text(
          _errorMessage,
          style: TextStyle(fontSize: 18),
        )),
        Padding(
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () => refreshCallback(),
            child: Icon(Icons.refresh_rounded),
          ),
        )
      ],
    );
  }
}
