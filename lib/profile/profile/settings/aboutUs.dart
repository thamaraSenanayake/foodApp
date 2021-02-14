import 'package:flutter/material.dart';

import '../../../const.dart';


class AboutUs extends StatefulWidget {
  AboutUs({Key key,}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
                            "About Us",
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
                          "This app is specially designed for the basic level manufacturer in the food and manufacturing sector.\n\n"
                          +"The main objective is to bring good clean and quality products to the consumer. It also allows the customer to get a complete description of the products they are consuming, which gives them good faith in the products they are buying.\n\n"
                          +"It also facilitates the manufacturer to deliver their products to the customers without the intervention of any intermediaries. \n\n"
                          +"Allowing the consumer to be systematically informed of that information from the date of commencement to the end of production gives the manufacturer more time from the initial stage of production to find a good market to market their product. For that reason, there is no production surplus.\n\n"
                          +"Providing a good marketing medium for the basic producer (farmer) to sell his product can build consumer confidence in his product by educating the customer about his product information from the date of commencement of production to the end, and also to gather a group of customers on his own Provided.\n",
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