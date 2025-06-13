import 'package:flutter/material.dart';

class Utils {
  static showModalBottom(
      {required BuildContext context, required Widget child}) {
    return showModalBottomSheet(
        backgroundColor: Colors.black26,
        constraints:
        BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 12),
        barrierColor: const Color(0xFF253444).withOpacity(0.8),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28), topRight: Radius.circular(28))),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 16),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(100)),
                        width: 32,
                        height: 4,
                      ),
                    ),
                    child
                  ]),
            ),
          );
        });
  }
}
