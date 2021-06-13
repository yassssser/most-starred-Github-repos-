import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TextErrorWidget extends StatelessWidget {
  final VoidCallback? actionEvent;
  String? errorMessage;
  TextErrorWidget({@required this.actionEvent, @required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: actionEvent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: "Une erreur est survenue. ",
                  style: TextStyle(color: Colors.red),
                ),
                TextSpan(
                  text: "Cliquer pour essayez",
                  style: TextStyle(color: Colors.green),
                ),
                kDebugMode
                    ? TextSpan(
                        text: errorMessage,
                        style: TextStyle(color: Colors.green),
                      )
                    : WidgetSpan(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
