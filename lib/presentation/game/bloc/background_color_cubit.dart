import 'package:ben_kimim/core/configs/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BackgroundColorCubit extends Cubit<Color> {
  BackgroundColorCubit() : super(AppColors.primary);

  /// Arkaplan rengini değiştir
  void setColor(Color color) => emit(color);

  /// Rengi varsayılan hale getir
  void reset() => emit(AppColors.primary);
}
