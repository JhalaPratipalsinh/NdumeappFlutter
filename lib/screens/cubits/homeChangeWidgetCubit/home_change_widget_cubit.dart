import 'package:flutter_bloc/flutter_bloc.dart';

class HomeChangeWidgetCubit extends Cubit<int> {
  HomeChangeWidgetCubit() : super(0);

  void changeHomeWidget(int position) {
    emit(position);
  }
}
