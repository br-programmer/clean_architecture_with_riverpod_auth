import 'app_user.dart';

class EmergencyAlert {
  EmergencyAlert({
    required this.id,
    required this.sender,
    required this.createdAt,
  });

  final String id;
  final AppUser sender;
  final DateTime createdAt;
}
