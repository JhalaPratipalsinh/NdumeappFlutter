import 'package:bloc/bloc.dart';

class BreedingRecordChangeTabCubit extends Cubit<int> {
  BreedingRecordChangeTabCubit() : super(0);

  void changeTab(int pos) {
    emit(pos);
  }
}
