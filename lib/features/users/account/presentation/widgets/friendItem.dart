import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/follow.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/unfollow.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';

class FriendItem extends StatefulWidget {
  final PublicBaseAccountResponse friend;
  final AccountRepository repository;
  final TokenStorage tokenStorage;

  const FriendItem({
    super.key,
    required this.friend,
    required this.repository,
    required this.tokenStorage,
  });
  
  @override
  State<FriendItem> createState() => _FriendItemState();
}

class _FriendItemState extends State<FriendItem> {

  String userId = '';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Future.microtask(() async {
      if (!mounted) return;
      String? res = await widget.tokenStorage.getToken();
      if(res== null || !mounted) return;
      setState(() {
        userId = res;
      });
    });

    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if(userId== widget.friend.id) {
                GoRouter.of(context).push(accountProfileScreenRoute);
              }
              else {
                GoRouter.of(context).push(
                  publicAccountInformationScreenRoute,
                  extra: widget.friend.id,
                );
              }
            },
            child: Row(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                          imageUrl: widget.friend.avatar!.images.first.fullPath,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 70,
                            height: 70,
                            color: theme.secondaryHeaderColor,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 70,
                            height: 70,
                            color: theme.secondaryHeaderColor,
                            child: const Icon(Icons.error),
                          ),
                        ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.friend.displayName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "@${widget.friend.username}",
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (widget.friend.isFollowing && (userId != widget.friend.id && userId != ''))
            TextButton(
              onPressed:() async{
                if(!mounted) return;
                setState(() {
                  widget.friend.isFollowing = false;
                });
                bool res = await widget.repository.unfollow(Unfollow(userId: widget.friend.id));

                if(!res){
                  if(!mounted) return;
                  setState(() {
                    widget.friend.isFollowing = true;
                  });
                }
              },
              style: Theme.of(context).textButtonTheme.style!.copyWith(
                padding: WidgetStatePropertyAll(const EdgeInsets.symmetric(vertical: 5, horizontal: 8)),
                minimumSize: WidgetStatePropertyAll(Size(0,0)), 
              ),
              child: const Text("Unfollow"),
            ),
          if (!widget.friend.isFollowing && (userId != widget.friend.id && userId != ''))
            TextButton(
              onPressed:() async{
                if(!mounted) return;
                setState(() {
                  widget.friend.isFollowing = true;
                });
                bool res = await widget.repository.follow(Follow(userId: widget.friend.id));

                if(!res){
                  if(!mounted) return;
                  setState(() {
                    widget.friend.isFollowing = false;
                  });
                }
              },
              style: Theme.of(context).textButtonTheme.style!.copyWith(
                backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.secondary),
                padding: WidgetStatePropertyAll(const EdgeInsets.symmetric(vertical: 5, horizontal: 8)),
                minimumSize: WidgetStatePropertyAll(Size(0,0)), 
              ),
              child: const Text("Follow"),
            ),
        ],
      ),
    );
  }
}
