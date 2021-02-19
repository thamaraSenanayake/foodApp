import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../const.dart';


class ViewLocation extends StatefulWidget {
  final LatLng location;
  ViewLocation({Key key,@required this.location}) : super(key: key);

  @override
  _ViewLocationState createState() => _ViewLocationState();
}

class _ViewLocationState extends State<ViewLocation>  {
  double _width = 0.0;
  double _height = 0.0;
  GoogleMapController _mapController;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  LatLng _location;
  CameraPosition  _cameraPosition;


  _initLocation() async {
    _location = widget.location;
    _addMark(LatLng(_location.latitude, _location.longitude));
  }

  _addMark(LatLng position) async {
    _location = position;
    _markers.remove("YOUR_LOCATION");
    var marker = Marker(
      markerId: MarkerId("YOUR_LOCATION"),
      position: LatLng(position.latitude,position.longitude),
      // icon: BitmapDescriptor.fromBytes(markerIcon),
    );
    if(mounted){
      setState(() {
        _cameraPosition =  CameraPosition(
          target: LatLng(position.latitude,position.longitude),
          zoom: 15
        );
        _markers[MarkerId("YOUR_LOCATION")] = marker;
      });
    }
  }

  @override
  void initState() { 
    super.initState();
    _initLocation();
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
                            "View Location",
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

              Container(
                height: _height - 128,
                width: _width,
                child: _cameraPosition != null? GoogleMap(
                  initialCameraPosition: _cameraPosition,
                  onMapCreated: _onMapCreated,
                  mapToolbarEnabled: true,
                  // onCameraMoveStarted: cameraMove(),
                  markers: Set<Marker>.of(_markers.values),
                  onTap: (latLng){
                    _addMark(latLng);
                  },
                ):SpinKitDoubleBounce(
                  color: AppData.thirdColor,
                  size: 50.0,
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    if(mounted){
      setState(() {
        _mapController = controller;
        // controller.setMapStyle(_mapStyle);
      });
    }
  }

}