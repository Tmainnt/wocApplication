import 'package:flutter/material.dart';
import 'package:woc/theme/widget_color.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{
  
  WidgetColor widgetColor = WidgetColor();

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          width: double.infinity,      
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black, 
                offset: Offset(0,0), 
                blurRadius: 5,
              )
            ]
          ),
        ),
      ]
    );
  }
}