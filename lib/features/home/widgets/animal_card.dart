import 'package:animel_core/features/home/data/animal_demo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/already_home_dialog.dart';

class AnimalCard extends StatelessWidget {
  final AnimalDemo data;
  const AnimalCard({super.key, required this.data});

  bool get _isAlreadyHome => (data.status).toLowerCase() == 'already home';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isAlreadyHome) {
          showDialog(
            context: context,
            builder: (_) => const AlreadyHomeDialog(),
          );
        } else {
          context.go(
            '/animal-details',
            extra: {
              'name': data.name,
              'status': data.status,
              'category': data.category.isNotEmpty ? data.category : 'Cat',
              'color': data.color.isNotEmpty ? data.color : 'Gray & White',
              'age': data.age.isNotEmpty ? data.age : '2 years',
              'ownerName': data.ownerName.isNotEmpty
                  ? data.ownerName
                  : 'Lara Ramez',
              'ownerEmail': data.ownerEmail.isNotEmpty ? data.ownerEmail : '',
              'description': data.description.isNotEmpty
                  ? data.description
                  : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              'location': data.location,
              'imageUrl': data.imageUrl,
              'reward': 100.0,
            },
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF3E9F5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: SizedBox(
                    height: 140,
                    width: double.infinity,
                    child: Image.network(data.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                if (_isAlreadyHome)
                  Positioned(
                    top: 10,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4B1A45), Color(0xFFE27D60)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'Already Home',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(1, 4, 1, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      data.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Color(0xFF8C3A7B),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          data.location,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: Color(0xFF8C3A7B),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        data.timeAgo,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
