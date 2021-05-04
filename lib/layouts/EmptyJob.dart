
import 'package:flutter/material.dart';

class EmptyJob extends StatelessWidget {
   final String title;
  final String message;

  const EmptyJob({Key key, this.title:'Nothing here', this.message:'Add new item to get started here'}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title,style: TextStyle(fontSize: 32.0,color: Colors.black54),),
          Text(message,style:TextStyle(fontSize: 16.0,color: Colors.black54),),
        ],
      ),
    );
  }
}
