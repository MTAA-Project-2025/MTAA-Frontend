import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/userFullAccountResponse.dart';

abstract class AccountEvent {}

class LoadAccountEvent extends AccountEvent {
  final UserFullAccountResponse account;

  LoadAccountEvent({required this.account});
}

class ChangeAccountAvatarEvent extends AccountEvent {
  final MyImageGroupResponse newImage;

  ChangeAccountAvatarEvent({required this.newImage});
}

class ChangeAccountDisplayNameEvent extends AccountEvent {
  final String newDisplayName;

  ChangeAccountDisplayNameEvent({required this.newDisplayName});
}

class ChangeAccountUsernameEvent extends AccountEvent {
  final String newUsername;

  ChangeAccountUsernameEvent({required this.newUsername});
}

class ChangeAccountPhoneNumberEvent extends AccountEvent {
  final String newPhoneNumber;

  ChangeAccountPhoneNumberEvent({required this.newPhoneNumber});
}

class ChangeAccountEmailAddressEvent extends AccountEvent {
  final String newEmailAddress;

  ChangeAccountEmailAddressEvent({required this.newEmailAddress});
}

class ChangeAccountBirthdateEvent extends AccountEvent {
  final DateTime newBirthdate;

  ChangeAccountBirthdateEvent({required this.newBirthdate});
}

class ChangeAccountLikesCountEvent extends AccountEvent {
  final int newLikesCount;

  ChangeAccountLikesCountEvent({required this.newLikesCount});
}

class ChangeAccountFollowersCount extends AccountEvent {
  final int newFollowersCount;

  ChangeAccountFollowersCount({required this.newFollowersCount});
}

class ChangeAccountFriendsCount extends AccountEvent {
  final int newFriendsCount;

  ChangeAccountFriendsCount({required this.newFriendsCount});
}