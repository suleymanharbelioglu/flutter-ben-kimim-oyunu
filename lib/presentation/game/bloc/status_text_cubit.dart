import 'package:flutter_bloc/flutter_bloc.dart';

class StatusTextCubit extends Cubit<String?> {
  StatusTextCubit() : super(null);

  void show(String text) => emit(text);
  void hide() => emit(null);
}
