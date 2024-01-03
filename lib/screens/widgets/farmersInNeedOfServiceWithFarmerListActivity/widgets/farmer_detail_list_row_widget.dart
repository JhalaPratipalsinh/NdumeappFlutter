import 'package:flutter/material.dart';

class FarmerDetailListRowWidget extends StatelessWidget {
  const FarmerDetailListRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text(
        'Ronnie Kimani',
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text('28764237642364', style: TextStyle(color: Colors.white)),
      trailing: Text('23 Records', style: TextStyle(color: Colors.white)),
    );
  }
}
