import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/model/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../const.dart';
import 'locationError.dart';


class SetLocation extends StatefulWidget {
  final User user;
  final LatLng location;
  final Function(LatLng) setLocation;
  SetLocation({Key key,@required this.user,@required this.location,@required this.setLocation}) : super(key: key);

  @override
  _SetLocationState createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> implements LocationErrorListener {
  double _width = 0.0;
  double _height = 0.0;
  GoogleMapController _mapController;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  LatLng _location;
  CameraPosition  _cameraPosition;


  _initLocation() async {
    print("get location");
    Position position;
    if(widget.location == null){
      try{
        position = await getCurrentPosition(desiredAccuracy:LocationAccuracy.best);
      }
      catch (e){
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, _, __) => LocationError(
              listener: this,
            ),
            opaque: false
          ),
        );
        return;
      }
      _location = LatLng(position.latitude, position.longitude);
    }else{
      _location = widget.location;
    }
    _addMark(_location);
  }

  _addMark(LatLng position) async {
    _location = position;
    // final Uint8List markerIcon = await getBytesFromAsset('assets/icon/user.png', 100);
    _markers.remove("YOUR_LOCATION");
    var marker = Marker(
      markerId: MarkerId("YOUR_LOCATION"),
      position: LatLng(position.latitude,position.longitude),
      // icon: BitmapDescriptor.fromBytes(markerIcon),
    );

    setState(() {
      _cameraPosition =  CameraPosition(
        target: LatLng(position.latitude,position.longitude),
        zoom: 15
      );
      _markers[MarkerId("YOUR_LOCATION")] = marker;
    });
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
                              widget.setLocation(_location);
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Set Location",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800
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
                ):SpinKitSquareCircle(
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
    setState(() {
      _mapController = controller;
      // controller.setMapStyle(_mapStyle);
    });
  }

  @override
  click(bool option) async{
    await new Future.delayed(const Duration(seconds : 2));
    _initLocation();
  }

}