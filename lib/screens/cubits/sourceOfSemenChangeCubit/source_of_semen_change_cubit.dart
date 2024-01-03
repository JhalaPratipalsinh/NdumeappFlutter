import 'package:flutter_bloc/flutter_bloc.dart';

class SourceOFSemenChangeCubit extends Cubit<String> {
  SourceOFSemenChangeCubit() : super("");

  void selectSourceOfSemen(String semenSource) {
    emit(semenSource);
  }
}
