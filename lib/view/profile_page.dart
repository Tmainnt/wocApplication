import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woc/provider/user_provider.dart';
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
    final userData = Provider.of<UserProvider>(context, listen: true).queryUser;
    
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
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), 
              bottomRight: Radius.circular(10)
            ),
            color: Colors.white
          ),
          child: Stack(
            children: [
              SizedBox(
                height: 70,
                width: double.infinity,
                child:  userData == null ? Image.asset("") : userData.backgroundImage.isEmpty 
                        ? Image.asset("") : Image.network(userData.backgroundImage),
              ),
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  child: SizedBox(
                    height: 69,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]
    );
  }
}