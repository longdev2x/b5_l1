import 'package:flutter_riverpod/flutter_riverpod.dart';

final quantityProductProvider = StateProvider.autoDispose<int>((ref) => 1);