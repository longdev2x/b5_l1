import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexSelectedProvider = StateProvider.autoDispose<int>((ref) => 0);