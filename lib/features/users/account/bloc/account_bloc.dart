import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/features/users/account/bloc/account_events.dart';
import 'package:mtaa_frontend/features/users/account/bloc/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountState(account: null)) {
    on<LoadAccountEvent>((event, emit) {
      emit(AccountState(account: event.account));
    });
    on<ChangeAccountAvatarEvent>((event, emit) {
      if(state.account==null)return;
      state.account!.avatar = event.newImage;
      emit(AccountState(account: state.account));
    });
    on<ChangeAccountDisplayNameEvent>((event, emit) {
      if(state.account==null)return;
      state.account!.displayName = event.newDisplayName;
      emit(AccountState(account: state.account));
    });
    on<ChangeAccountUsernameEvent>((event, emit) {
      if(state.account==null)return;
      state.account!.username = event.newUsername;
      emit(AccountState(account: state.account));
    });
    on<ChangeAccountPhoneNumberEvent>((event, emit) {
      if(state.account==null)return;
      state.account!.phoneNumber = event.newPhoneNumber;
      emit(AccountState(account: state.account));
    });
    on<ChangeAccountEmailAddressEvent>((event, emit) {
      if(state.account==null)return;
      state.account!.email = event.newEmailAddress;
      emit(AccountState(account: state.account));
    });
    on<ChangeAccountBirthdateEvent>((event, emit) {
      if(state.account==null)return;
      state.account!.birthDate = event.newBirthdate;
      emit(AccountState(account: state.account));
    });
    on<ChangeAccountLikesCountEvent>((event, emit) {
      if(state.account==null)return;
      state.account!.likesCount = event.newLikesCount;
      emit(AccountState(account: state.account));
    });
    on<ChangeAccountFollowersCount>((event, emit) {
      if(state.account==null)return;
      state.account!.followersCount = event.newFollowersCount;
      emit(AccountState(account: state.account));
    });
    on<ChangeAccountFriendsCount>((event, emit) {
      if(state.account==null)return;
      state.account!.friendsCount = event.newFriendsCount;
      emit(AccountState(account: state.account));
    });
  }
}

