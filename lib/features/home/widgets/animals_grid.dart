import 'package:animel_core/features/home/data/animal_demo.dart';
import 'package:flutter/material.dart';
import 'animal_card.dart';

class AnimalsGrid extends StatelessWidget {
  const AnimalsGrid({super.key});

  final animals = const [
    AnimalDemo(
      name: 'Luciffar',
      imageUrl:
          'https://images.pexels.com/photos/127409/pexels-photo-127409.jpeg',
      location:
          'Cairo, Nasr City, El Hay El Asher, Ahmed El Zomor Street, in front of Al Tawheed Mosque.',
      timeAgo: '13 days ago',
      status: 'Lost',
      category: 'Cat',
      color: 'Dark brown and white',
      age: '2 years',
      ownerName: 'Lara Ramez',
      ownerEmail: 'lararamez123@gmail.com',
      description:
          'My cat, Luciffar, went missing on Oct 11 at around 5:30 PM. Last seen near Ahmed El Zomor St, El Hay El Asher, Nasr City (in front of Al Tawheed Mosque). Gray tabby with white paws and he doesn\'t get along well with people.',
      reward: 100,
    ),
    AnimalDemo(
      name: 'Luciffar',
      imageUrl:
          'https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg',
      location:
          'Cairo, Nasr City, El Hay El Asher, Ahmed El Zomor Street, in front of Al Tawheed Mosque.',
      timeAgo: '10 days ago',
      status: 'Already Home',
      category: 'Cat',
      color: 'Orange and white',
      age: '2 years',
      ownerName: 'Lara Ramez',
      ownerEmail: 'lararamez123@gmail.com',
      description:
          'Luciffar has been safely returned home thanks to the community efforts.',
      reward: 100,
    ),
    AnimalDemo(
      name: 'Snow',
      imageUrl:
          'https://images.pexels.com/photos/4587995/pexels-photo-4587995.jpeg',
      location: 'Giza, 6th of October City',
      timeAgo: '5 days ago',
      status: 'Lost',
      category: 'Dog',
      color: 'White',
      age: '1 year',
      ownerName: 'Omar Khaled',
      ownerEmail: 'omar.khaled@example.com',
      description:
          'Friendly white dog, responds to the name Snow. Last seen near 6th of October, central park area.',
      reward: 50,
    ),
    AnimalDemo(
      name: 'Rocky',
      imageUrl:
          'https://images.pexels.com/photos/5731862/pexels-photo-5731862.jpeg',
      location: 'Alexandria, Miami',
      timeAgo: '2 days ago',
      status: 'Found',
      category: 'Dog',
      color: 'Brown',
      age: '3 years',
      ownerName: 'Salma Hassan',
      ownerEmail: 'salma.hassan@example.com',
      description:
          'Found wandering near the corniche in Miami, Alexandria. Very calm and wearing a blue collar.',
      reward: null,
    ),
    AnimalDemo(
      name: 'Milo',
      imageUrl:
          'https://images.pexels.com/photos/1390361/pexels-photo-1390361.jpeg',
      location: 'Cairo, Downtown',
      timeAgo: '1 day ago',
      status: 'Lost',
      category: 'Cat',
      color: 'Gray',
      age: '8 months',
      ownerName: 'Nour Adel',
      ownerEmail: 'nour.adel@example.com',
      description:
          'Playful kitten, last seen near Talaat Harb Square. Very curious and may follow people.',
      reward: 80,
    ),
    AnimalDemo(
      name: 'Bella',
      imageUrl:
          'https://images.pexels.com/photos/208984/pexels-photo-208984.jpeg',
      location: 'Nasr City',
      timeAgo: '7 days ago',
      status: 'Already Home',
      category: 'Dog',
      color: 'Golden',
      age: '4 years',
      ownerName: 'Mahmoud Ali',
      ownerEmail: 'mahmoud.ali@example.com',
      description:
          'Bella is now safely back home. She is a gentle golden retriever loved by the whole family.',
      reward: 150,
    ),
    AnimalDemo(
      name: 'Shadow',
      imageUrl:
          'https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg',
      location: 'Giza, El Haram',
      timeAgo: '3 days ago',
      status: 'Lost',
      category: 'Cat',
      color: 'Black',
      age: '3 years',
      ownerName: 'Aya Fathy',
      ownerEmail: 'aya.fathy@example.com',
      description:
          'Black cat with green eyes, scared of loud noises. Last seen near El Haram street.',
      reward: 60,
    ),
    AnimalDemo(
      name: 'Oreo',
      imageUrl:
          'https://images.pexels.com/photos/236606/pexels-photo-236606.jpeg',
      location: 'Alexandria, Smouha',
      timeAgo: '12 days ago',
      status: 'Adopt',
      category: 'Cat',
      color: 'Black and white',
      age: '1.5 years',
      ownerName: 'HopePaw Shelter',
      ownerEmail: 'contact@hopepaw.org',
      description:
          'Oreo is looking for a loving home. Very friendly with people, calm and house-trained.',
      reward: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: animals.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) {
        final item = animals[index];
        return AnimalCard(data: item);
      },
    );
  }
}
