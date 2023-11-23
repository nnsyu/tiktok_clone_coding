import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StfScreen extends StatefulWidget {
  const StfScreen({super.key});

  @override
  State<StfScreen> createState() => _StfScreenState();
}

class _StfScreenState extends State<StfScreen> {
  int _clicks = 0;

  void _increase() {
    setState(() {
      _clicks++;
    });
  }

  @override
  void dispose() {
    print(_clicks);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('im built !');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$_clicks',
            style: TextStyle(
              fontSize: 48,
            ),
          ),
          TextButton(
            onPressed: _increase,
            child: Text('+'),
          ),
        ],
      ),
    );
  }
}
