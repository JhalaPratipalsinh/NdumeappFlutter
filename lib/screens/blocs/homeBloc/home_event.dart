part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class SearchFarmerEvent extends HomeEvent {
  final String mobileNo;

  const SearchFarmerEvent({required this.mobileNo});

  @override
  List<Object?> get props => [mobileNo];
}

class AddFarmerEvent extends HomeEvent {
  final AddFarmerReqModel addFarmerReq;

  const AddFarmerEvent({required this.addFarmerReq});

  @override
  List<Object?> get props => [addFarmerReq];
}

class UpdateFarmerEvent extends HomeEvent{

  final String farmerVetId;
  final String gender;
  final String county;
  final String subCounty;
  final String ward;

  const UpdateFarmerEvent({required this.farmerVetId,required this.gender,required this.county,required this.subCounty,required this.ward});

  @override
  List<Object?> get props => [farmerVetId,gender,county,subCounty,ward];

}
