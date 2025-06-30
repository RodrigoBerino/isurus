import 'package:uuid/uuid.dart';

class IdGenerator {
  static String generate() => const Uuid().v4();
}
