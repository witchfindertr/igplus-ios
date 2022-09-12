import 'package:hive/hive.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:http/http.dart' as http;
import 'package:igplus_ios/domain/entities/report.dart';

abstract class LocalDataSource {
  Report? getCachedReport();
  Future<void> cacheReport({required Report report});
  List<Friend>? getCachedFriendsList({required String boxKey});
  Future<void> cacheFriendsList({required List<Friend> friendsList, required String boxKey});
  int getNumberOfFriendsInBox({required String boxKey});
}

class LocalDataSourceImp extends LocalDataSource {
  final http.Client client;

  LocalDataSourceImp({required this.client});

  // ----------------------->
  // report ------------------>
  // ----------------------->
  @override
  Future<void> cacheReport({required Report report}) async {
    final reportBox = Hive.box<Report>(Report.boxKey);
    try {
      await reportBox.put('report', report);
    } catch (e) {
      print(e);
    }
  }

  @override
  Report? getCachedReport() {
    try {
      final reportBox = Hive.box<Report>(Report.boxKey);
      // reportBox.deleteFromDisk();
      Report? report;
      report = reportBox.get('report');
      return report;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // ----------------------->
  // Friends ------------------>
  // ----------------------->

  @override
  List<Friend>? getCachedFriendsList({required String boxKey}) {
    Box<Friend> friendsBox = Hive.box<Friend>(boxKey);

    if (friendsBox.isEmpty) {
      return null;
    } else {
      final List<Friend> friendsList = friendsBox.values.toList();
      // List.generate(friendBox.length, (index) => friendBox.getAt(index)).whereType<Friend>().toList();
      return friendsList;
    }
  }

  @override
  Future<void> cacheFriendsList({required List<Friend> friendsList, required String boxKey}) async {
    Box<Friend> friendsBox = Hive.box<Friend>(boxKey);

    final List<Friend> cachedFriendsList = friendsBox.values.toList();
    final List<Friend> newFriendsListToAdd;
    // new friends list
    if (boxKey != Friend.followersBoxKey && boxKey != Friend.followingsBoxKey) {
      // keep only new friends in the list
      final List<Friend> friendsToKeep = cachedFriendsList
          .where((friend) => friend.createdOn.isAfter(DateTime.now().subtract(const Duration(days: 1))))
          .toList();
      await friendsBox.clear();
      newFriendsListToAdd = [
        ...friendsList
            .where((friend) => friendsToKeep.indexWhere((element) => friend.igUserId == element.igUserId) == -1)
            .toList(),
        ...friendsToKeep
      ];
    } else {
      newFriendsListToAdd = friendsList
          .where((friend) => cachedFriendsList.indexWhere((element) => friend.igUserId == element.igUserId) == -1)
          .toList();
    }

    try {
      for (var e in newFriendsListToAdd) {
        friendsBox.add(e);
      }
    } catch (e) {
      print(e);
    }
  }

  // get number of friends in the box
  @override
  int getNumberOfFriendsInBox({required String boxKey}) {
    Box<Friend> friendsBox = Hive.box<Friend>(boxKey);
    return friendsBox.length;
  }
}
