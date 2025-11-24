import 'package:animel_core/features/auth/presentation/welcome_auth_screen.dart';
import 'package:animel_core/features/home/presentation/animal_details_screen.dart';
import 'package:animel_core/features/profile/presentation/contact_screen.dart';
import 'package:animel_core/features/profile/presentation/profile_language_screen.dart';
import 'package:go_router/go_router.dart';

// ONBOARDING
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/onboarding/presentation/choose_language_screen.dart';
import '../../features/onboarding/presentation/permissions_info_screen.dart';

// AUTH
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/verify_email_screen.dart';

// HOME & OTHERS (زي ما عملنا قبل كده)
import '../../features/home/presentation/home_screen.dart';
import '../../features/search/presentation/search_screen.dart';
import '../../features/report/presentation/report_step1_screen.dart';
import '../../features/adoption/presentation/adopt_list_screen.dart';
import '../../features/donation/presentation/donation_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/profile/presentation/my_account_screen.dart';
import '../../features/profile/presentation/edit_account_screen.dart';
import '../../features/profile/presentation/my_pets_screen.dart';
import '../../features/profile/presentation/add_pet_step1_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/splash",
    routes: [
      // ONBOARDING
      GoRoute(
        path: "/splash",
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: "/choose-language",
        builder: (context, state) => const ChooseLanguageScreen(),
      ),
      GoRoute(
        path: "/permissions-info",
        builder: (context, state) => const PermissionsInfoScreen(),
      ),
      GoRoute(
        path: "/welcome-auth",
        builder: (context, state) => const WelcomeAuthScreen(),
      ),

      // AUTH
      GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: "/register",
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: "/verify-email",
        builder: (context, state) => const VerifyEmailScreen(),
      ),

      // MAIN
      GoRoute(path: "/home", builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: "/search",
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: "/report",
        builder: (context, state) => const ReportStep1Screen(),
      ),
      GoRoute(
        path: "/profile/language",
        builder: (context, state) => const ProfileLanguageScreen(),
      ),
      GoRoute(
        path: "/profile/contact",
        builder: (context, state) => const ContactScreen(),
      ),

      GoRoute(
        path: "/adopt",
        builder: (context, state) => const AdoptListScreen(),
      ),
      GoRoute(
        path: "/donation",
        builder: (context, state) => const DonationScreen(),
      ),
      GoRoute(
        path: "/profile",
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: "/profile/account",
        builder: (context, state) => const MyAccountScreen(),
      ),
      GoRoute(
        path: "/profile/account/edit",
        builder: (context, state) => const EditAccountScreen(),
      ),
      GoRoute(
        path: "/profile/pets",
        builder: (context, state) => const MyPetsScreen(),
      ),
      GoRoute(
        path: "/profile/pets/add-step1",
        builder: (context, state) => const AddPetStep2Screen(),
      ),
      GoRoute(
        path: "/animal-details",
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return AnimalDetailsScreen(
            name: data['name'] as String,
            status: data['status'] as String,
            category: data['category'] as String,
            color: data['color'] as String,
            age: data['age'] as String,
            ownerName: data['ownerName'] as String,
            ownerEmail: data['ownerEmail'] as String,
            description: data['description'] as String,
            location: data['location'] as String,
            imageUrl: data['imageUrl'] as String,
            reward: data['reward'] as double?,
          );
        },
      ),
    ],
  );
}
