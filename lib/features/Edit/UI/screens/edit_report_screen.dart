import 'package:flutter/material.dart';
import 'package:hopepaw/features/Home/Data/models/animal_report.dart';
import 'package:hopepaw/features/Edit/Data/firebase/edit_services.dart';

class EditReportScreen extends StatefulWidget {
  final AnimalReport report;
  const EditReportScreen({super.key, required this.report});

  @override
  State<EditReportScreen> createState() => _EditReportScreenState();
}

class _EditReportScreenState extends State<EditReportScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _colorController;
  late TextEditingController _ageController;
  late TextEditingController _rewardController;
  late TextEditingController _userNameController;
  late TextEditingController _userEmailController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;

  bool _isSaving = false;
  bool _isDone = false;
  String? _category;

  static const Color _darkPurple = Color(0xFF44174E);
  static const Color _purpleColor = Color(0xFF7B61FF);

  @override
  void initState() {
    super.initState();
    final r = widget.report;
    _nameController = TextEditingController(text: r.name ?? '');
    _colorController = TextEditingController(text: r.color);
    _ageController = TextEditingController(text: r.age?.toString() ?? '');
    _rewardController = TextEditingController(text: r.reward?.toString() ?? '');
    _userNameController = TextEditingController(text: r.userName);
    _userEmailController = TextEditingController(text: r.userEmail);
    _descriptionController = TextEditingController(text: r.description);
    _locationController = TextEditingController(text: r.location);
    _category = r.category;
    _isDone = r.status.toLowerCase() == 'done';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _colorController.dispose();
    _ageController.dispose();
    _rewardController.dispose();
    _userNameController.dispose();
    _userEmailController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final r = widget.report;
    final updated = r.copyWith(
      name: _nameController.text.trim().isEmpty
          ? null
          : _nameController.text.trim(),
      category: _category ?? r.category,
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
      status: _isDone ? 'Done' : r.status,
    );

    try {
      await EditService.updateReport(updated);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Report updated')));
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to update: $e')));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Report'),
        backgroundColor: _darkPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Animal Name'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Category'),
                items: const [
                  DropdownMenuItem(value: 'Dog', child: Text('Dog')),
                  DropdownMenuItem(value: 'Cat', child: Text('Cat')),
                  DropdownMenuItem(value: 'Bird', child: Text('Bird')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (v) => setState(() => _category = v),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _colorController,
                decoration: const InputDecoration(labelText: 'Color'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ageController,
                      decoration: const InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _rewardController,
                      decoration: const InputDecoration(labelText: 'Reward'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _userNameController,
                decoration: const InputDecoration(labelText: 'Your Name'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _userEmailController,
                decoration: const InputDecoration(labelText: 'Your Email'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mark as done',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Switch(
                    value: _isDone,
                    onChanged: (v) => setState(() => _isDone = v),
                    activeColor: _purpleColor,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _darkPurple,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Save', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
