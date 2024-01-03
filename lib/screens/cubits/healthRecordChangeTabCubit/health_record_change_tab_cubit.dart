import 'package:bloc/bloc.dart';

class HealthRecordChangeTabCubit extends Cubit<int> {
  HealthRecordChangeTabCubit() : super(0);

  void changeTab(int pos) {
    emit(pos);
  }
}
