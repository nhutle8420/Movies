import 'package:flutter/material.dart';


class DescriptionCheckui extends StatefulWidget {
  var newId;
  var newType;
  DescriptionCheckui(this.newId, this.newType);

  @override
  State<DescriptionCheckui> createState() => _descriptioncheckuiState();
}

class _descriptioncheckuiState extends State<DescriptionCheckui> {
  checktype() {
    if (widget.newType.toString() == 'movie') {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return checktype();
  }
}

Widget errorui(context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Error'),
    ),
    body: Center(
      child: Text('no Such page found'),
    ),
  );
}
