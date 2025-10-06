import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BackgroundColorCubit extends Cubit<Color> {
  BackgroundColorCubit() : super(Colors.white);

  /// Arkaplan rengini değiştir
  void setColor(Color color) => emit(color);

  /// Rengi varsayılan hale getir
  void reset() => emit(Colors.white);
}
