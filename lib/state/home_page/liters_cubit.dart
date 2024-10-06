import 'package:flutter_bloc/flutter_bloc.dart';

class LitersCubit extends Cubit<int> {
  LitersCubit(super.initialState);

  void update() {
    if (state < 10) {
      emit(state + 1);
    } else {
      emit(0);
    }
  }
}
