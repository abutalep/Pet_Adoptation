import 'package:flutter/material.dart';
import 'package:hopepaw/features/Home/Data/models/animal_report.dart';

class AnimalDetailsScreen extends StatelessWidget {
  final AnimalReport report;
  const AnimalDetailsScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 280,
              child: PageView(
                children: report.images != null && report.images!.isNotEmpty
                    ? report.images!.map((img) {
                        return Image.network(img, fit: BoxFit.cover);
                      }).toList()
                    : [
                        Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.image, size: 80),
                        ),
                      ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.name ?? "Unknown",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFECE8ED),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.search_rounded,
                              color: Color(0xFF44174E),
                              size: 16,
                            ),
                            const Text(
                              "Lost",
                              style: TextStyle(
                                color: Color(0xFF44174E),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFF9E1CC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          report.reward != null
                              ? "Reward : ${report.reward}\$"
                              : "",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFFF383C),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Category : ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF44174E),
                          ),
                        ),
                        TextSpan(
                          text: report.category ,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Color : ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF44174E),
                          ),
                        ),
                        TextSpan(
                          text: report.color,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Age : ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF44174E),
                          ),
                        ),
                        TextSpan(
                          text: '${report.age}',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.person, size: 28),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              report.userName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              report.userEmail,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.call_outlined,
                          color: Color(0xFF44174E),
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.message_outlined,
                          color: Color(0xFF44174E),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF44174E),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    report.description,
                    style: const TextStyle(fontSize: 15),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Location",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF44174E),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.purple),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          report.location,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
