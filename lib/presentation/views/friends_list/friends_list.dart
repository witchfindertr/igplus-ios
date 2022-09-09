import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/presentation/blocs/friends_list/cubit/friends_list_cubit.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({Key? key, required String this.type}) : super(key: key);

  final String? type;

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<FriendsListCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    final String pageTitle;
    switch (widget.type) {
      case "notFollowingYouBack":
        pageTitle = "Didn't Following You Back";
        break;
      case "youDontFollowBack":
        pageTitle = "You Don't Follow Back";
        break;
      case "newFollowers":
        pageTitle = "New Followers";
        break;
      case "lostFollowers":
        pageTitle = "Lost Followers";
        break;
      default:
        pageTitle = "";
        break;
    }
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: ColorsManager.appBack,
        leading: GestureDetector(
            onTap: () => GoRouter.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 26.0,
            )),
        middle: const Text("New Followers", style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorsManager.appBack,
          body: BlocBuilder<FriendsListCubit, FriendsListState>(
            builder: (context, state) {
              if (state is FriendsListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FriendsListSuccess) {
                List<Friend> friendList = state.friendsList;
                return ListView.builder(
                    itemCount: friendList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          tileColor: ColorsManager.cardBack,
                          onTap: () => _openProfileLinkOnInsta(friendList[index].username),
                          leading: Hero(
                            tag: index,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(friendList[index].picture),
                            ),
                          ),
                          title:
                              Text(friendList[index].username, style: const TextStyle(color: ColorsManager.cardText)),
                          trailing: const Icon(
                            FontAwesomeIcons.instagram,
                            color: ColorsManager.cardText,
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _openProfileLinkOnInsta(String username) {
    var url = 'http://instagram.com/$username';
    final AndroidIntent intent =
        AndroidIntent(action: 'action_view', data: Uri.encodeFull(url), package: 'com.instagram.android');
    intent.launch();
  }
}
