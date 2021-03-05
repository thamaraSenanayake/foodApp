import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/profile/profile/settings/aboutUs.dart';
import 'package:food_app/profile/profile/settings/language.dart';
import 'package:food_app/profile/profile/settings/privacypolicy.dart';
import 'package:food_app/res/WarningDialog.dart';

import '../../../const.dart';

class SettingsScreen extends StatefulWidget {
  final User user;
  final Function logout;
  final Function changeTheme;
  SettingsScreen({Key key,@required this.user,@required this.logout, this.changeTheme}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> implements WarningDialogClickListener  {
  double _width = 0.0;
  double _height = 0.0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height= MediaQuery.of(context).size.height;
    });
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width : _width,
        height :_height,
        color: AppData.isDarkMode? Colors.black.withOpacity(0.8):Colors.white,
        child: SafeArea(
          child: Column(
            children: [

              //header
              Column(
                children: [
                  Container(
                    width : _width,
                    height: 50,
                    // color: Colors.red,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 35,
                                  color: AppData.secondaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Settings",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppData.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 100,
              ),

              Column(
                children: [
                  Container(
                    child: ListTile(
                      onTap: ()  {
                        setState(() {
                          AppData.isDarkMode = !AppData.isDarkMode;
                          Color primaryColor = AppData.primaryColor; 
                          AppData.primaryColor = AppData.secondaryColor;
                          AppData.secondaryColor = primaryColor;
                        });
                        widget.changeTheme();
                        final storage = new FlutterSecureStorage();
                        storage.write(key: KeyContainer.IS_DARK,value: AppData.isDarkMode.toString());
                      },
                      title: Text(
                        "Dark Theme",
                        style: TextStyle(
                          color: AppData.secondaryColor,
                          fontSize: 20
                        ),
                      ),
                      trailing: Icon(
                        AppData.isDarkMode? Icons.brightness_high :Icons.brightness_low,
                        color: AppData.secondaryColor,
                      ),
                    ),
                  ),
                  Container(
                    child: ListTile(
                      onTap: (){
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, _, __) => Language(
                            ),
                            opaque: false
                          ),
                        );
                      },
                      title: Text(
                        "Choose the language",
                        style: TextStyle(
                          color: AppData.secondaryColor,
                          fontSize: 20
                        ),
                      ),
                      trailing: Icon(
                        Icons.language_outlined,
                        color: AppData.secondaryColor,
                      ),
                    ),
                  ),
                  Container(
                    child: ListTile(
                      onTap: (){
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, _, __) => PrivacyPolicy(
                            ),
                            opaque: false
                          ),
                        );
                      },
                      title: Text(
                        "Privacy policy",
                        style: TextStyle(
                          color: AppData.secondaryColor,
                          fontSize: 20
                        ),
                      ),
                      trailing: Icon(
                        Icons.privacy_tip,
                        color: AppData.secondaryColor,
                      ),
                    ),
                  ),
                  Container(
                    child: ListTile(
                      title: Text(
                        "Rate us",
                        style: TextStyle(
                          color: AppData.secondaryColor,
                          fontSize: 20
                        ),
                      ),
                      trailing: Icon(
                        Icons.rate_review_sharp,
                        color: AppData.secondaryColor,
                      ),
                    ),
                  ),
                  Container(
                    child: ListTile(
                      onTap: (){
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, _, __) => AboutUs(
                            ),
                            opaque: false
                          ),
                        );
                      },
                      title: Text(
                        "About",
                        style: TextStyle(
                          color: AppData.secondaryColor,
                          fontSize: 20
                        ),
                      ),
                      trailing: Icon(
                        Icons.info,
                        color: AppData.secondaryColor,
                      ),
                    ),
                  ),
                  Container(
                    child: ListTile(
                      onTap: (){
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, _, __) => WarningDialog(
                              listener: this,
                              msg: "Are you sure you want to logout from app?",
                            ),
                            opaque: false
                          ),
                        );
                        
                      },
                      title: Text(
                        "Logout",
                        style: TextStyle(
                          color: AppData.secondaryColor,
                          fontSize: 20
                        ),
                      ),
                      trailing: Icon(
                        Icons.add_to_home_screen,
                        color: AppData.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),

              Container()

            ],
          ),
        ),
      ),
    );
  }

  @override
  clickYes() {
    Navigator.pop(context);
    widget.logout();
  }

}