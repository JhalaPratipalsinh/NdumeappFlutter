part of 'farmer_bloc.dart';

abstract class FarmerEvent extends Equatable {
  const FarmerEvent();
}

class FetchFarmersEvent extends FarmerEvent {
  final String vetID;
  int? start;
  int? limit;

  FetchFarmersEvent({required this.vetID, this.start, this.limit});

  @override
  List<Object?> get props => [vetID, start, limit];
}

class GetFarmerNeedService extends FarmerEvent {
  final String vetId;
  final String fromDate;
  final String toDate;

  const GetFarmerNeedService(
      {required this.vetId, required this.fromDate, required this.toDate});

  @override
  List<Object?> get props => [vetId, fromDate, toDate];
}
