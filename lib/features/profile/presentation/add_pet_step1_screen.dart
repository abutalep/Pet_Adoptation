import 'package:animel_core/features/profile/widgets/add_photos_box.dart';
import 'package:animel_core/features/profile/widgets/choice_chip_button.dart';
import 'package:animel_core/features/profile/widgets/dropdown_field.dart';
import 'package:animel_core/features/profile/widgets/header_icon.dart';
import 'package:animel_core/features/profile/widgets/pet_text_field.dart';
import 'package:flutter/material.dart';

class AddPetStep2Screen extends StatefulWidget {
  const AddPetStep2Screen({super.key});

  @override
  State<AddPetStep2Screen> createState() => _AddPetStep2ScreenState();
}

class _AddPetStep2ScreenState extends State<AddPetStep2Screen> {
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _weightController = TextEditingController();
  final _aboutController = TextEditingController();
  final _favoritesController = TextEditingController();

  String _selectedPetType = 'Cat';
  String _selectedGender = 'Male';
  String _selectedSize = 'Small';
  String _selectedBreed = 'Mixed';
  String _selectedColor = 'Brown';
  String _selectedBehavior = 'Calm';

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _weightController.dispose();
    _aboutController.dispose();
    _favoritesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF4B1A45);
    const lightPurple = Color(0xFFF6ECF3);

    return Scaffold(
      backgroundColor: lightPurple,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: purple,
        title: const Text(
          'Set a pet profile',
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
                  const HeaderIcon(),
                  const SizedBox(height: 16),

                  PetTextField(label: 'Name', controller: _nameController),
                  const SizedBox(height: 12),

                  PetTextField(
                    label: 'Date of birth',
                    controller: _dobController,
                    suffixIcon: Icons.calendar_today_outlined,
                    readOnly: true,
                    onTap: () async {
                      final now = DateTime.now();
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: DateTime(now.year - 25),
                        lastDate: now,
                      );
                      if (picked != null) {
                        _dobController.text =
                            '${picked.day}/${picked.month}/${picked.year}';
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Pet',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ChoiceChipButton(
                        label: 'Cat',
                        isSelected: _selectedPetType == 'Cat',
                        onTap: () => setState(() => _selectedPetType = 'Cat'),
                      ),
                      const SizedBox(width: 8),
                      ChoiceChipButton(
                        label: 'Dog',
                        isSelected: _selectedPetType == 'Dog',
                        onTap: () => setState(() => _selectedPetType = 'Dog'),
                      ),
                      const SizedBox(width: 8),
                      ChoiceChipButton(
                        label: 'Bird',
                        isSelected: _selectedPetType == 'Bird',
                        onTap: () => setState(() => _selectedPetType = 'Bird'),
                      ),
                      const SizedBox(width: 8),
                      ChoiceChipButton(
                        label: 'Other',
                        isSelected: _selectedPetType == 'Other',
                        onTap: () => setState(() => _selectedPetType = 'Other'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  DropdownField(
                    label: 'Breed',
                    value: _selectedBreed,
                    items: const [
                      'Mixed',
                      'Persian',
                      'Siamese',
                      'Golden Retriever',
                      'German Shepherd',
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedBreed = val);
                      }
                    },
                  ),
                  const SizedBox(height: 12),

                  DropdownField(
                    label: 'Color',
                    value: _selectedColor,
                    items: const ['Brown', 'Black', 'White', 'Gray', 'Mixed'],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedColor = val);
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Gender',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ChoiceChipButton(
                        label: 'Male',
                        isSelected: _selectedGender == 'Male',
                        onTap: () => setState(() => _selectedGender = 'Male'),
                      ),
                      const SizedBox(width: 8),
                      ChoiceChipButton(
                        label: 'Female',
                        isSelected: _selectedGender == 'Female',
                        onTap: () => setState(() => _selectedGender = 'Female'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  PetTextField(
                    label: 'Weight (kg)',
                    controller: _weightController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Size',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ChoiceChipButton(
                        label: 'Small',
                        isSelected: _selectedSize == 'Small',
                        onTap: () => setState(() => _selectedSize = 'Small'),
                      ),
                      const SizedBox(width: 8),
                      ChoiceChipButton(
                        label: 'Medium',
                        isSelected: _selectedSize == 'Medium',
                        onTap: () => setState(() => _selectedSize = 'Medium'),
                      ),
                      const SizedBox(width: 8),
                      ChoiceChipButton(
                        label: 'Large',
                        isSelected: _selectedSize == 'Large',
                        onTap: () => setState(() => _selectedSize = 'Large'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  DropdownField(
                    label: 'Behavior',
                    value: _selectedBehavior,
                    items: const ['Calm', 'Playful', 'Aggressive', 'Shy'],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedBehavior = val);
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  PetTextField(
                    label: 'About / Special marks',
                    controller: _aboutController,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 12),

                  PetTextField(
                    label: 'Favorites',
                    controller: _favoritesController,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Add more photos',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AddPhotosBox(
                    onTap: () {
                      // image picker
                    },
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // save pet profile
                      },
                      child: const Text(
                        'Save',
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
