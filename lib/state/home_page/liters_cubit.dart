import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_beer/state/home_page/liters_state.dart';

class LitersCubit extends Cubit<LitersState> {
  LitersCubit() : super(const LitersState()) {
    _fetchLiters();
  }

  void update() {
    if (state.liters < 10) {
      emit(state.copyWith(liters: state.liters + 1));
    } else {
      emit(state.copyWith(liters: 0));
    }
  }

  Future<void> _fetchLiters() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final response = await http.get(Uri.parse(_getRandomInt));

      if (response.statusCode == 200) {
        final result = (((jsonDecode(response.body) as List<dynamic>).first)
            as Map<String, dynamic>)['random'];
        emit(state.copyWith(liters: result, isLoading: false));
      } else {
        emit(state.copyWith(
          error: 'Failed to load liters: ${response.statusCode}',
          isLoading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to load liters: $e',
        isLoading: false,
      ));
    }
  }

  static const String _getRandomInt =
      'https://csrng.net/csrng/csrng.php?min=1&max=9';
}
