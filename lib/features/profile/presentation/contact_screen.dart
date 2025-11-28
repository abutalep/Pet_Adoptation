import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

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
        title: const Text(
          'Contact',
          style: TextStyle(color: purple, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: purple,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFE0C7B2),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      children: const [
                        _ContactCard(
                          icon: Icons.location_on_outlined,
                          title: 'Location',
                          subtitle:
                              '5 Abbas El Akkad Street, Nasr City, Cairo, Egypt',
                        ),
                        SizedBox(height: 12),
                        _ContactCard(
                          icon: Icons.phone_outlined,
                          title: '+20 155459381',
                          subtitle: 'Tap to call',
                        ),
                        SizedBox(height: 12),
                        _ContactCard(
                          icon: Icons.email_outlined,
                          title: 'hopepaw@example.com',
                          subtitle: 'Tap to send email',
                        ),
                        SizedBox(height: 12),
                        _ContactCard(
                          icon: Icons.public,
                          title: 'https://hopefultails.wordpress.com',
                          subtitle: 'Tap to open website',
                        ),
                      ],
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

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    const cardColor = Color(0xFFFFE7CC);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.brown[700]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
