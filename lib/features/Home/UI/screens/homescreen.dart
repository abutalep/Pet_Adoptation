import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hopepaw/features/providers/user_provider.dart';
import 'package:hopepaw/features/Home/Data/firebase/home_firebase.dart';
import 'package:hopepaw/features/Home/UI/screens/widgets/filter_bar.dart';
import 'package:hopepaw/features/Home/UI/screens/widgets/profile_card.dart';
import 'package:hopepaw/features/Home/UI/screens/widgets/report_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";
  String selectedStatus = "All";
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final displayName =
        userProvider.userData?['displayName'] ??
        FirebaseAuth.instance.currentUser?.displayName ??
        "User";
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FilterBar(
                  selectedCategory: selectedCategory,
                  selectedStatus: selectedStatus,
                  categories: const ['All', 'Cat', 'Dog', 'Bird', 'Others'],
                  onCategoryChanged: (value) =>
                      setState(() => selectedCategory = value),
                  onStatusChanged: (value) =>
                      setState(() => selectedStatus = value),
                ),
              ),
              SizedBox(height: 8),
              StreamBuilder(
                stream: HomeFirebase.getPostsByCategory(
                  category: selectedCategory,
                  status: selectedStatus,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data!.isEmpty) {
                    return Center(child: Text('No Reports found.'));
                  }
                  final reports = snapshot.data!;
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: reports.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                    ),
                    itemBuilder: (context, index) => Card(
                      elevation: 2,
                      child: AspectRatio(
                        aspectRatio: 0.75,
                        child: ReportCard(report: reports[index]),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
