import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TaskForm(),
            ),
            SizedBox(
              height: 200, // Adjust the height of the map container
              child: GoogleMapWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskForm extends StatefulWidget {
  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _taskController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _taskController,
          decoration: InputDecoration(labelText: 'Task'),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
            ),
            SizedBox(width: 8.0),
            ElevatedButton(
              onPressed: () async {
                final selectedLocation = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationSelectionPage()),
                );
                if (selectedLocation != null) {
                  setState(() {
                    _locationController.text = selectedLocation;
                  });
                }
              },
              child: Text('Select Location'),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Icon(Icons.calendar_today),
            SizedBox(width: 8.0),
            Text(
              _selectedDate == null
                  ? 'Select Date'
                  : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
            ),
            SizedBox(width: 8.0),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Pick Date'),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            final String task = _taskController.text;
            final String location = _locationController.text;
            final String? date = _selectedDate != null
                ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                : null;
            print('Task: $task, Location: $location, Date: $date');
            _taskController.clear();
            _locationController.clear();
          },
          child: Text('Add Task'),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _taskController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}

class LocationSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Location Selection Page',
              style: TextStyle(fontSize: 20.0),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Selected Location');
              },
              child: Text('Select Location'),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleMapWidget extends StatefulWidget {
  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(0, 0),
        zoom: 10,
      ),
      myLocationEnabled: true,
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }
}
