import 'package:animel_core/features/home/widgets/google_static_map.dart';
import 'package:animel_core/features/report/widgets/report_dropdown_field.dart';
import 'package:animel_core/features/report/widgets/report_photo_picker.dart';
import 'package:animel_core/features/report/widgets/report_text_field.dart';
import 'package:animel_core/features/report/widgets/report_type_toggle.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';

class ReportStep1Screen extends StatefulWidget {
  const ReportStep1Screen({super.key});

  @override
  State<ReportStep1Screen> createState() => _ReportStep1ScreenState();
}

class _ReportStep1ScreenState extends State<ReportStep1Screen> {
  final _nameController = TextEditingController();
  final _colorController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _rewardController = TextEditingController();
  final _lastSeenDateController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String _selectedType = 'Lost';
  String _selectedCategory = 'Cat';

  @override
  void dispose() {
    _nameController.dispose();
    _colorController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _descriptionController.dispose();
    _rewardController.dispose();
    _lastSeenDateController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const lightPurple = Color(0xFFF6ECF3);
    const purple = Color(0xFF4B1A45);

    return Scaffold(
      backgroundColor: lightPurple,
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: purple,
        title: const Text(
          'report animal',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                children: [
                  ReportPhotoPicker(
                    onTap: () {
                      // TODO: فتح Image Picker وإضافة الصور (حد أقصى 4)
                    },
                  ),
                  const SizedBox(height: 16),

                  ReportTypeToggle(
                    selected: _selectedType,
                    onChanged: (value) {
                      setState(() => _selectedType = value);
                    },
                  ),
                  const SizedBox(height: 16),

                  ReportTextField(
                    label: 'Animal name *',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 12),

                  ReportTextField(label: 'Color', controller: _colorController),
                  const SizedBox(height: 12),

                  ReportDropdownField(
                    label: 'Category',
                    value: _selectedCategory,
                    items: const ['Cat', 'Dog', 'Bird', 'Other'],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedCategory = val);
                      }
                    },
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: ReportTextField(
                          label: 'Age',
                          controller: _ageController,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ReportTextField(
                          label: 'Gender',
                          controller: _genderController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  ReportTextField(
                    label: 'Description',
                    controller: _descriptionController,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 12),

                  ReportTextField(
                    label: 'Reward (100\$, 100Eg)',
                    controller: _rewardController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Last seen*',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),

                  ReportTextField(
                    label: 'Date and time',
                    controller: _lastSeenDateController,
                    readOnly: true,
                    suffixIcon: Icons.calendar_today_outlined,
                    onTap: () async {
                      final now = DateTime.now();
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: DateTime(now.year - 5),
                        lastDate: now.add(const Duration(days: 1)),
                      );
                      if (picked != null) {
                        _lastSeenDateController.text =
                            '${picked.day}/${picked.month}/${picked.year}';
                      }
                    },
                  ),
                  const SizedBox(height: 12),

                  ReportTextField(
                    label: 'Enter address',
                    controller: _addressController,
                  ),
                  const SizedBox(height: 12),

                  // لو عندك GoogleStaticMap في core/widgets
                  GoogleStaticMap(
                    address: _addressController.text.isEmpty
                        ? 'Cairo, Egypt'
                        : _addressController.text,
                    height: 170,
                    borderRadius: 16,
                  ),
                  const SizedBox(height: 16),

                  ReportTextField(
                    label: 'E-mail*',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),

                  ReportTextField(
                    label: 'Phone number*',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // TODO: validate + send report
                      },
                      child: const Text(
                        'Add animal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
