import 'package:bloc/bloc.dart';

class BreedingAndHealthChangeTabCubit extends Cubit<int> {
  BreedingAndHealthChangeTabCubit() : super(0);

  void changeTab(int pos) {
    emit(pos);
  }
}
