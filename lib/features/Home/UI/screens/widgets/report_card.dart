import 'package:flutter/material.dart';
import 'package:hopepaw/features/Home/Data/models/animal_report.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({super.key, required this.report});
  final AnimalReport report;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: report.images!.isNotEmpty
                ? Image.network(report.images!.first, fit: BoxFit.cover)
                : Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported, size: 40),
                  ),
          ),
          SizedBox(height: 3),
          Text(
            report.name ?? "Guest",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: Color(0xFF44174E),
              ),
              SizedBox(width: 4),
              Text(report.location),
            ],
          ),
        ],
      ),
    );
  }
}
