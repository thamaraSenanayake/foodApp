import 'package:flutter/material.dart';

import '../../../const.dart';


class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({Key key,}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  double _width = 0.0;
  double _height = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height= MediaQuery.of(context).size.height;
    });
    return Scaffold(
      body: Container(
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
                            "Privacy Policy",
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

              Expanded(
                child: Container(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top:20.0,left: 20,right: 20),
                        child: Text(
                          "This application provide a safe and useful service.\n\n"+

                          "Collection Information posted on this application. If you choose to provide us with personal information, you are consenting to the transfer and storage of that information on our servers.We collect and store the following personal information: \n\n"+
                          
                          "• Email address, contact information, and (depending on the service used) sometimes Computer sign-on data, and response to advertisements \n\n"+
                          
                          "• Other information, including users' IP address.\n\n\n\n"+
                          
                          
                          
                          "Use\n"+
                          "We use users' personal information to:\n\n"
                          
                          "• Provide our services \n\n"
                          
                          "• Encourage safe trading and enforce our policies\n\n"
                          
                          "• Customize users experience, measure interest in our services \n\n"
                          
                          "• Improve our services and inform users about servicesand updates \n\n"
                          
                          "• Communicate marketing and promotional offers to you according to your preferences \n\n"
                          
                          "• Do other things for users as described when we collect the information \n\n\n\n"
                          
                          
                          
                          "Disclosure \n\n"
                          
                          "We don't sell or rent users' personal information to third parties for their marketing purposes without users' explicit consent.We may disclose personal information to respond to legal requirements, enforce our policies, respond to claims that a posting or other content violates other's rights, or protect anyone's rights, property, or safety.\n\n\n\n"
                          
                          
                          "Security\n\n"
                          
                          "We use lots of tools (encryption, passwords, physical security) to protect your personal information against unauthorized access and disclosure.\n"
                          "All personal electronic details will be kept private by the Service except for those that you wish to disclose.It is unacceptable to disclose the contact information of others through the Service.If you violate the laws of your country of residence and/or the terms of use of the Service you forfeit your privacy rights over your personal information.",
                          style: TextStyle(
                            color: AppData.secondaryColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                            height: 1.5
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  
}