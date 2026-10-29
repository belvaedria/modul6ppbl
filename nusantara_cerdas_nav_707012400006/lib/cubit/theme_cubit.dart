import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void ubahTema(bool modeGelap) {
    emit(modeGelap ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTema() {
    emit(
      state == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}
