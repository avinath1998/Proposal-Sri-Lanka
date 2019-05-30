import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:proposal/data/repository/proposal_data_repository.dart';
import 'package:proposal/models/user.dart';
import './contact_request.dart';
import 'package:proposal/exceptions/data_fetch_exception.dart';

class ContactRequestBloc
    extends Bloc<ContactRequestEvent, ContactRequestState> {
  ProposalUser proposalUser;
  final CurrentUser currentUser;
  final ProposalDataRepository dataRepository;

  ContactRequestBloc(this.proposalUser, this.currentUser, this.dataRepository);

  void sendContactRequest(bool requesting) {
    dispatch(SendContactRequestEvent(requesting));
  }

  @override
  ContactRequestState get initialState => InitialContactRequestState();

  @override
  Stream<ContactRequestState> mapEventToState(
    ContactRequestEvent event,
  ) async* {
    if (event is SendContactRequestEvent) {
      yield* _sendRequest(event.isRequesting);
    } else if (event is SuccessContactingRequestEvnet) {
      yield ContactRequestSentSuccessState(
          event.isRequesting, event.hasContactBeenAccepted);
    } else if (event is ErrorContactingRequestEvnet) {
      yield (ContactRequestSentErrorState(event.errorMsg));
    }
  }

  Stream<ContactRequestState> _sendRequest(bool requesting) async* {
    print("Sending Contact Request");
    try {
      yield (ContactRequestSendingState());
      proposalUser = await dataRepository.requestAContact(
          proposalUser, currentUser, requesting);
      yield (ContactRequestSentSuccessState(
          requesting, proposalUser.hasContactAcceptedContactRequest));
    } on DataFetchException catch (e) {
      print(e.toString());
      yield (ContactRequestSentErrorState(e.toString()));
    }
  }
}
