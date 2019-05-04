import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:proposal/models/user.dart';
import './profile.dart';
import 'package:proposal/data/repository/proposal_data_repository.dart';
import 'package:proposal/exceptions/data_fetch_exception.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProposalUser proposalUser;
  final CurrentUser currentUser;
  final ProposalDataRepository dataRepository;
  final String _tag = "ProfileBloc: ";

  ProfileBloc(this.proposalUser, this.currentUser, this.dataRepository);

  void requestAUsersContact() {
    dispatch(RequestContactEvent());
  }

  @override
  ProfileState get initialState => InitialProfileState();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is RequestContactEvent) {
      yield* _sendContactRequest();
    } else if (event is RequestedContactEvent) {
      yield (RequestedContactState());
    } else if (event is RequestingContactErrorEvent) {
      yield (RequestingContactErrorState(event.errorMsg));
    } else if (event is NoRequestedContactEvent) {
      yield (NoRequestedContactState());
    }
  }

  Stream<ProfileState> _sendContactRequest() async* {
    try {
      String id =
          await dataRepository.requestAContact(proposalUser, currentUser);
      if (id != null && id.isNotEmpty) {}
    } on DataFetchException catch (e) {
      print("$_tag ${e.message}");
      yield (RequestingContactErrorState(e.toString()));
    }
  }
}
