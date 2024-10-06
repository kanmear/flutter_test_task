import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';

class LitersCubit extends Cubit<int> {
  LitersCubit() : super(0) {
    _fetchLiters();
  }

  void update() {
    if (state < 10) {
      emit(state + 1);
    } else {
      emit(0);
    }
  }

  Future<void> _fetchLiters() async {
    final response = await http.get(Uri.parse(getRandomInt));

    if (response.statusCode == 200) {
      final result = (((jsonDecode(response.body) as List<dynamic>).first)
          as Map<String, dynamic>)['random'];
      emit(result);
    } else {
      throw Exception('Failed to load liters');
    }
  }

  static const String getRandomInt =
      'https://csrng.net/csrng/csrng.php?min=1&max=9';
}
