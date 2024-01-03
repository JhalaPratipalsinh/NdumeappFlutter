part of 'breeding_bloc.dart';

abstract class BreedingEvent extends Equatable {
  const BreedingEvent();
}

class AddBreedingEvent extends BreedingEvent {
  final AddBreedingRecordReqModel addBreedingRecordReq;
  final bool isUpdate;

  const AddBreedingEvent({required this.addBreedingRecordReq, this.isUpdate = false});

  @override
  List<Object?> get props => [addBreedingRecordReq, isUpdate];
}

class FetchBreedingEvent extends BreedingEvent {
  final String mobileNoOrVetId;
  final bool isMobileNo;
  final bool isVatId;
  final bool isVerified;

  const FetchBreedingEvent({
    required this.mobileNoOrVetId,
    required this.isMobileNo,
    this.isVatId=false,
    this.isVerified=false,
  });

  @override
  List<Object?> get props => [mobileNoOrVetId, isMobileNo];
}

class FatchPaidBreedingListEvent extends BreedingEvent{
   final String vatId;
   const FatchPaidBreedingListEvent({required this.vatId});

   @override
   List<Object> get props=>[vatId];
}

class FetchBreedingDetailEvent extends BreedingEvent {
  final String breedingID;

  const FetchBreedingDetailEvent({
    required this.breedingID,
  });

  @override
  List<Object?> get props => [breedingID];
}

class RemoveBreedingEvent extends BreedingEvent {
  final String breedingID;

  const RemoveBreedingEvent({
    required this.breedingID,
  });

  @override
  List<Object?> get props => [breedingID];
}

class FetchSourceOfSemenListEvent extends BreedingEvent {
  final String semenType;

  const FetchSourceOfSemenListEvent({
    required this.semenType,
  });

  @override
  List<Object?> get props => [semenType];
}
