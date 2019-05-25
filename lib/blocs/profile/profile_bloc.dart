import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:proposal/models/user.dart';
import './profile.dart';
import 'package:proposal/data/repository/proposal_data_repository.dart';
import 'package:proposal/exceptions/data_fetch_exception.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProposalUser proposalUser;
  final CurrentUser currentUser;
  final ProposalDataRepository dataRepository;
  final String _tag = "ProfileBloc: ";

  ProfileBloc(this.proposalUser, this.currentUser, this.dataRepository);

  void requestProposalUserFullDetails() {
    dispatch(FetchContactFullDetails());
  }

  @override
  ProfileState get initialState => InitialProfileState();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchContactFullDetails) {
      yield* _fetchContactDetailsInFull();
    } else if (event is FetchingContactDetailsError) {
      yield FetchingFullDetailsState();
    } else if (event is FetchingContactDetailsError) {
      yield ErrorFetchingFullDetailsState(event.errorMsg);
    }
  }

  Stream<ProfileState> _fetchContactDetailsInFull() async* {
    try {
      proposalUser = await dataRepository.fetchProposalUserInFullDetails(
          currentUser, proposalUser);
      yield SuccessFetchingFullDetailsState();
    } on DataFetchException catch (e) {
      yield (ErrorFetchingFullDetailsState(e.toString()));
    }
  }

  // Stream<ProfileState> _sendContactRequest() async* {
  //   try {
  //     String id =
  //         await dataRepository.requestAContact(proposalUser, currentUser);
  //     if (id != null && id.isNotEmpty) {}
  //   } on DataFetchException catch (e) {
  //     print("$_tag ${e.message}");
  //     yield (RequestingContactErrorState(e.toString()));
  //   }
  // }
}
