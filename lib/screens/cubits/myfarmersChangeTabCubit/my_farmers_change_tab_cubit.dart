import 'package:flutter_bloc/flutter_bloc.dart';

class MyFarmersChangeTabCubit extends Cubit<int> {
  MyFarmersChangeTabCubit() : super(0);

  void changeTab(int pos) {
    emit(pos);
  }
}
