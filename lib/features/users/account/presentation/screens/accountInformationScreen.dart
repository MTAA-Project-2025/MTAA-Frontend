import 'package:flutter/material.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/baseFullAccountResponse.dart';

class AccountInformationScreen extends StatelessWidget {
  final BaseFullAccountResponse account;

  const AccountInformationScreen({Key? key, required this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: account.avatar != null
                      ? NetworkImage(account.avatar!.images.first.fullPath)
                      : AssetImage('assets/default_avatar.png') as ImageProvider,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.displayName,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      '@${account.username}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        Text('${account.friendsCount} Friends'),
                        SizedBox(width: 8),
                        Text('${account.followersCount} Followers'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
              },
              child: Text('Change Profile'),
            ),
            ElevatedButton(
              onPressed: () {
              },
              child: Text('Notifications'),
            ),
          ],
        ),
      ),
    );
  }
}