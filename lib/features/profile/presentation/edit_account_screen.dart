import 'package:animel_core/features/profile/widgets/account_header_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final _firstName = TextEditingController(text: "John");
  final _lastName = TextEditingController(text: "Doe");
  final _email = TextEditingController(text: "john@example.com");
  final _address = TextEditingController(text: "Cairo, Egypt");

  bool _isLoading = false;

  Future<void> _save() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    if (!mounted) return;
    context.pop();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit account")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const AccountHeaderIcon(),
            AppTextField(label: "First name", controller: _firstName),
            const SizedBox(height: 12),
            AppTextField(label: "Last name", controller: _lastName),
            const SizedBox(height: 12),
            AppTextField(label: "Email", controller: _email),
            const SizedBox(height: 12),
            AppTextField(label: "Address", controller: _address, maxLines: 2),
            const SizedBox(height: 24),
            AppButton(title: "Save", isLoading: _isLoading, onPressed: _save),
          ],
        ),
      ),
    );
  }
}
