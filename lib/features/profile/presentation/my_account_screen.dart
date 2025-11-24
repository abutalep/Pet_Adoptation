import 'package:animel_core/features/profile/widgets/account_buttons_row.dart';
import 'package:animel_core/features/profile/widgets/account_header_icon.dart';
import 'package:animel_core/features/profile/widgets/profile_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const lightPurple = Color(0xFFF6ECF3);
    const purple = Color(0xFF4B1A45);

    return Scaffold(
      backgroundColor: lightPurple,
      appBar: AppBar(
        backgroundColor: lightPurple,
        elevation: 0,
        leading: const BackButton(color: purple),
        foregroundColor: purple,
        centerTitle: false,
        title: const Text(
          'My account',
          style: TextStyle(
            color: purple,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 60,
                  ),
                  children: [
                    const AccountHeaderIcon(),
                    const SizedBox(height: 40),
                    Row(
                      children: const [
                        Expanded(
                          child: ProfileTextField(
                            label: 'First name',
                            initialValue: 'Metwally',
                            enabled: false,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: ProfileTextField(
                            label: 'Last name',
                            initialValue: 'Metwally',
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const ProfileTextField(
                      label: 'Email',
                      initialValue: 'name@example.com',
                      enabled: false,
                    ),
                    const SizedBox(height: 12),
                    const ProfileTextField(
                      label: 'Address',
                      initialValue: '',
                      enabled: false,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Expanded(
                          child: ProfileTextField(
                            label: 'State',
                            initialValue: 'Metwally',
                            enabled: false,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: ProfileTextField(
                            label: 'City/Town',
                            initialValue: 'Metwally',
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    AccountButtonsRow(
                      onClose: () => context.pop(),
                      onEdit: () => context.push('/profile/account/edit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
