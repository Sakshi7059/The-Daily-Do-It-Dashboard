import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSelectionPage extends StatefulWidget {
  @override
  _LocationSelectionPageState createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  
  late GoogleMapController _mapController; 

  LatLng _selectedLocation = LatLng(18.5204, 73.8567);

  @override
  void dispose() {
    _mapController.dispose(); 
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Stack(
        children: [
          GoogleMap(
           
            initialCameraPosition: CameraPosition(
              target: _selectedLocation,
              zoom: 15,
            ),
            onTap: (LatLng latLng) {
              setState(() {
                _selectedLocation = latLng;
              });
            },
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _selectedLocation);
              },
              child: Text('Select Location'),
            ),
          ),
        ],
      ),
    );
  }
}
