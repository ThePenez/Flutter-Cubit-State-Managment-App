import 'package:bloc/bloc.dart';
import 'package:flutter_cubit/cubit/app_cubit_states.dart';
import 'package:flutter_cubit/services/data_services.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data}) : super(InitialState()) {
    emit(WelcomeState());
  }

  final DataServices data;
  late final places;

  void getData() async {
    try {
      emit(LoadingState());
      places = await data.getInfo();
      emit(LoadedState(places));
    } catch (e) {
      print(e);
    }
  }

  void detailPage(place) {
    emit(DetailState(place));
  }

  void goHome() {
    emit(LoadedState(places));
  }
}
