import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// removed localization import
// import 'package:hopepaw/features/report/Data/firebase/l10n/app_localizations.dart';
import 'package:hopepaw/features/report/Data/firebase/report_service.dart';
import 'package:hopepaw/features/report/Data/models/report_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final ImagePicker _picker = ImagePicker();
  final ReportService _reportService = ReportService();
  List<XFile> _images = [];
  bool _isSubmitting = false;

  MapController mapController = MapController();

  LatLng? selectedLocation;
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();

  String animalStatus = ""; // Lost | Found
  String? animalType; // Dog, Cat, etc. (category)
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _rewardController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _lostDateController = TextEditingController();

  // Pick images
  Future<void> _pickImages() async {
    final List<XFile> picked = await _picker.pickMultiImage();
    if (picked.isNotEmpty) {
      setState(() {
        _images = picked.take(4).toList();
      });
    }
  }

  // Tap on map
  void _onMapTap(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      selectedLocation = latlng;
      _latController.text = latlng.latitude.toStringAsFixed(5);
      _lngController.text = latlng.longitude.toStringAsFixed(5);
    });
  }

  // Get current location
  Future<void> _useCurrentLocation() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Location permission required')));
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    LatLng current = LatLng(position.latitude, position.longitude);

    setState(() {
      selectedLocation = current;
      _latController.text = current.latitude.toStringAsFixed(5);
      _lngController.text = current.longitude.toStringAsFixed(5);
    });

    mapController.move(current, 15);
  }

  // Validate + Submit
  Future<void> _submitReport() async {
    if (_images.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please upload images')));
      return;
    }

    if (animalStatus.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select status')));
      return;
    }

    if (selectedLocation == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please pick a location')));
      return;
    }

    // Validate required fields
    if (animalType == null || animalType!.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select animal type')));
      return;
    }

    if (_colorController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter color')));
      return;
    }

    if (_userNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter name')));
      return;
    }

    if (_userEmailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter email')));
      return;
    }

    if (_descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter description')));
      return;
    }

    if (_locationController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter address')));
      return;
    }

    // منع إرسال متعدد
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final now = DateTime.now();
      final timestamp = now.millisecondsSinceEpoch;

      // Create AnimalReport model
      final report = AnimalReport(
        id: timestamp.toString(),
        name: _nameController.text.trim().isEmpty
            ? null
            : _nameController.text.trim(),
        category: animalType!,
        color: _colorController.text.trim(),
        age: _ageController.text.trim().isEmpty
            ? null
            : int.tryParse(_ageController.text.trim()),
        reward: _rewardController.text.trim().isEmpty
            ? null
            : double.tryParse(_rewardController.text.trim()),
        userName: _userNameController.text.trim(),
        userEmail: _userEmailController.text.trim(),
        description: _descriptionController.text.trim(),
        location: _locationController.text.trim(),
        latitude: selectedLocation?.latitude,
        longitude: selectedLocation?.longitude,
        lostDateTime: now,
        timestamp: timestamp,
        images: _images.map((image) => image.path).toList(),
        status: animalStatus,
      );

      // إرسال التقرير إلى Firebase
      String reportId = await _reportService.submitReport(report);
      // Report ID returned by the service (kept in case needed for further
      // processing later). We currently remain in the same bottom-nav tab and
      // therefore do not navigate back.

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Report added successfully (id: $reportId)'),
            backgroundColor: Colors.green,
          ),
        );


        setState(() {
          _images = [];
          animalStatus = "";
          animalType = null;
          selectedLocation = null;
          _latController.clear();
          _lngController.clear();
          _nameController.clear();
          _colorController.clear();
          _ageController.clear();
          _rewardController.clear();
          _userNameController.clear();
          _userEmailController.clear();
          _descriptionController.clear();
          _locationController.clear();
          _lostDateController.clear();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit the report: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }

    // Optional: Reset form after submission
    // setState(() {
    //   _images = [];
    //   animalStatus = "";
    //   animalType = null;
    //   selectedLocation = null;
    //   _latController.clear();
    //   _lngController.clear();
    //   _descriptionController.clear();
    //   _contactInfoController.clear();
    // });
  }

  @override
  void dispose() {
    _latController.dispose();
    _lngController.dispose();
    _nameController.dispose();
    _colorController.dispose();
    _ageController.dispose();
    _rewardController.dispose();
    _userNameController.dispose();
    _userEmailController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _lostDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const purpleColor = Color(0xFF7B61FF);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report Animal',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: purpleColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------------------- Upload Images --------------------
            Text(
              'Upload Images',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            GestureDetector(
              onTap: _pickImages,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: purpleColor, width: 1.5),
                ),
                child: _images.isEmpty
                    ? const Center(
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.grey,
                          size: 40,
                        ),
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(_images[index].path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemCount: _images.length,
                      ),
              ),
            ),

            const SizedBox(height: 20),

            // -------------------- Lost / Found --------------------
            Text(
              'Animal Status',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() => animalStatus = "Lost");
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: animalStatus == "Lost"
                          ? Colors.white
                          : purpleColor,
                      backgroundColor: animalStatus == "Lost"
                          ? purpleColor
                          : Colors.white,
                      side: const BorderSide(color: purpleColor),
                    ),
                    child: const Text('Lost'),
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() => animalStatus = "Found");
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: animalStatus == "Found"
                          ? Colors.white
                          : purpleColor,
                      backgroundColor: animalStatus == "Found"
                          ? purpleColor
                          : Colors.white,
                      side: const BorderSide(color: purpleColor),
                    ),
                    child: const Text('Found'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // -------------------- Animal Type --------------------
            Text(
              'Animal Type',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: animalType,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Select animal type',
                isDense: true,
              ),
              items: [
                const DropdownMenuItem(value: "Dog", child: Text('Dog')),
                const DropdownMenuItem(value: "Cat", child: Text('Cat')),
                const DropdownMenuItem(value: "Bird", child: Text('Bird')),
                const DropdownMenuItem(value: "Other", child: Text('Other')),
              ],
              onChanged: (value) {
                setState(() => animalType = value);
              },
            ),

            const SizedBox(height: 20),

            // -------------------- Animal Name --------------------
            Text(
              'Animal Name',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter animal name',
                prefixIcon: const Icon(Icons.pets),
                isDense: true,
              ),
            ),

            const SizedBox(height: 20),

            // -------------------- Color --------------------
            Text(
              'Color',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _colorController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter color',
                prefixIcon: const Icon(Icons.color_lens),
                isDense: true,
              ),
            ),

            const SizedBox(height: 20),

            // -------------------- Age & Reward --------------------
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Age',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Age",
                          isDense: true,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reward',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _rewardController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Amount",
                          prefixIcon: Icon(Icons.attach_money),
                          isDense: true,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // -------------------- User Info --------------------
            Text(
              'Your Information',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _userNameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Your Name',
                prefixIcon: const Icon(Icons.person),
                isDense: true,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _userEmailController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Your Email',
                prefixIcon: const Icon(Icons.email),
                isDense: true,
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 20),

            // -------------------- Description --------------------
            Text(
              'Description',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Add description',
              ),
            ),

            const SizedBox(height: 20),

            // -------------------- Location Address --------------------
            Text(
              'Location Address',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter address',
                prefixIcon: const Icon(Icons.location_on),
                isDense: true,
              ),
            ),

            const SizedBox(height: 20),

            // -------------------- Map --------------------
            Text(
              'Animal Location',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: const LatLng(30.033333, 31.233334),
                    initialZoom: 12,
                    onTap: _onMapTap,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    if (selectedLocation != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: selectedLocation!,
                            child: const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // -------------------- Coordinates --------------------
            Text(
              'Coordinates',
              style: const TextStyle(
                fontSize: 16,
                color: purpleColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _latController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Latitude',
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                Expanded(
                  child: TextField(
                    controller: _lngController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Longitude',
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _useCurrentLocation,
                icon: const Icon(Icons.my_location, color: Colors.white),
                label: const Text('Use Current Location'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: purpleColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // -------------------- Submit --------------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: purpleColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBackgroundColor: Colors.grey,
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : const Text(
                        'Add Animal',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
