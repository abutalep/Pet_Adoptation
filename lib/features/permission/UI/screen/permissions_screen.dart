import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hopepaw/features/auth/UI/screens/login_screen.dart';
import 'package:hopepaw/features/navigation/UI/screens/navigationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _locationPermissionGranted = false;
  bool _notificationPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    // Check location permission
    LocationPermission locationPermission = await Geolocator.checkPermission();
    setState(() {
      _locationPermissionGranted =
          locationPermission == LocationPermission.always ||
          locationPermission == LocationPermission.whileInUse;
    });

    // Check notification permission
    PermissionStatus notificationStatus = await Permission.notification.status;
    setState(() {
      _notificationPermissionGranted = notificationStatus.isGranted;
    });
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    setState(() {
      _locationPermissionGranted =
          permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    });

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      if (mounted) {
        _showLocationSettingsDialog();
      }
    }
  }

  Future<void> _requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.request();
    setState(() {
      _notificationPermissionGranted = status.isGranted;
    });
  }

  void _showLocationSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Required'),
        content: const Text(
          'Please enable location permission in your device settings. '
          'Go to Settings > Apps > Hope Paw > Permissions > Location and select "Allow all the time".',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Geolocator.openLocationSettings();
              Navigator.pop(context);
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _continueToHome() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const NavigationScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const darkPurple = Color(0xFF1B232C);
    const purpleColor = Color(0xFF7B61FF);
    const orangeColor = Color(0xFFED9E59);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Logo
              Hero(
                tag: 'logo',
                child: SvgPicture.asset(
                  'assets/Frame 208.svg',
                  width: 150,
                  height: 150,
                ),
              ),

              const SizedBox(height: 24),

              // App Name with gradient
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hope',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: darkPurple,
                      ),
                    ),
                    TextSpan(
                      text: 'Paw',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = LinearGradient(
                            colors: [purpleColor, orangeColor],
                          ).createShader(const Rect.fromLTWH(0, 0, 100, 50)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Welcome message
              Text(
                'Community welcomes you',
                style: TextStyle(
                  fontSize: 16,
                  color: darkPurple,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 32),

              // Instructions
              Text(
                'For the best experience, please follow these steps.',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Location Settings Section
              _buildPermissionSection(
                title: 'Location Settings',
                description:
                    'When a pet is lost, we need to connect with people nearby.',
                instruction:
                    'Please set your location (in your device settings) to "Allow all the time" for HOPEPAW.',
                privacyNote:
                    'Your location history is never stored. We respect and value your privacy.',
                isGranted: _locationPermissionGranted,
                onTap: _requestLocationPermission,
                icon: Icons.location_on,
                color: purpleColor,
              ),

              const SizedBox(height: 24),

              // Enable Notifications Section
              _buildPermissionSection(
                title: 'Enable Notifications',
                description:
                    'We notify people when a pet goes missing or when a search is in progress.',
                instruction:
                    'Please allow notifications to stay informed and help others.',
                privacyNote: null,
                isGranted: _notificationPermissionGranted,
                onTap: _requestNotificationPermission,
                icon: Icons.notifications,
                color: orangeColor,
              ),

              const SizedBox(height: 40),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _continueToHome,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionSection({
    required String title,
    required String description,
    required String instruction,
    String? privacyNote,
    required bool isGranted,
    required VoidCallback onTap,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isGranted ? color : Colors.grey[300]!,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1B232C),
                  ),
                ),
              ),
              if (isGranted)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.green[700],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Enabled',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          // Description
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),

          const SizedBox(height: 12),

          // Instruction
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withOpacity(0.2), width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, size: 18, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    instruction,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[800],
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Privacy Note
          if (privacyNote != null) ...[
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lock_outline, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    privacyNote,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ],

          // Action Button
          if (!isGranted) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onTap,
                icon: Icon(icon, color: color),
                label: Text('Enable $title', style: TextStyle(color: color)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: color, width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
