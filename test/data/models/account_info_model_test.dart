import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:igplus_ios/data/models/account_info_model.dart';
import 'package:igplus_ios/domain/entities/account_info.dart';

import '../../helpers/json_reader.dart';

void main() {
  final AccountInfoModel testAccountInfoModel = AccountInfoModel(
    igUserId: "54306109719",
    username: "ayman_26a",
    isPrivate: false,
    picture:
        "https://instagram.ffez2-2.fna.fbcdn.net/v/t51.2885-19/295774332_463034745234587_5831000511722660987_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.ffez2-2.fna.fbcdn.net&_nc_cat=111&_nc_ohc=72ZBx_YnFs4AX8TjKDJ&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AT-POOw4vL9CPhfkp16QGOqc1ry-AaYTVf18BTdx4Z5bpg&oe=62E66064&_nc_sid=8fd12b",
    followers: 203,
    following: 558,
    contactPhoneNumber: "",
    publicPhoneNumber: "",
    phoneCountryCode: "",
    publicEmail: "",
  );

  final testAccountInfo = AccountInfo(
    igUserId: "54306109719",
    username: "ayman_26a",
    isPrivate: false,
    picture:
        "https://instagram.ffez2-2.fna.fbcdn.net/v/t51.2885-19/295774332_463034745234587_5831000511722660987_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.ffez2-2.fna.fbcdn.net&_nc_cat=111&_nc_ohc=72ZBx_YnFs4AX8TjKDJ&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AT-POOw4vL9CPhfkp16QGOqc1ry-AaYTVf18BTdx4Z5bpg&oe=62E66064&_nc_sid=8fd12b",
    followers: 203,
    following: 558,
  );

  group('to entity', () {
    test('should return an AccountInfo entity', () {
      // assert
      final result = testAccountInfoModel.toEntity();
      expect(result, equals(testAccountInfo));
    });
  });

  group('from json by username', () {
    test('should return a AccountInfoModel from json', () {
      // arrange
      final Map<String, dynamic> jsonMap = jsonDecode(
        readJson('helpers/dummy_data/dummy_account_info_by_username_response.json'),
      );

      // act
      final result = AccountInfoModel.fromJsonByUsername(jsonMap);
      // assert
      expect(result, equals(testAccountInfoModel));
    });
  });

  group('from json by id', () {
    test('should return a AccountInfoModel from json', () {
      // arrange
      final Map<String, dynamic> jsonMap = jsonDecode(
        readJson('helpers/dummy_data/dummy_account_info_by_id_response.json'),
      );

      // act
      final result = AccountInfoModel.fromJsonById(jsonMap);
      // assert
      expect(result, equals(testAccountInfoModel));
    });
  });

  group('to json', () {
    test('should return a json map', () {
      // arrange
      final expectedJsonMap = {
        "igUserId": "54306109719",
        "username": "ayman_26a",
        "isPrivate": false,
        "picture":
            "https://instagram.ffez2-2.fna.fbcdn.net/v/t51.2885-19/295774332_463034745234587_5831000511722660987_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.ffez2-2.fna.fbcdn.net&_nc_cat=111&_nc_ohc=72ZBx_YnFs4AX8TjKDJ&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AT-POOw4vL9CPhfkp16QGOqc1ry-AaYTVf18BTdx4Z5bpg&oe=62E66064&_nc_sid=8fd12b",
        "followers": 203,
        "following": 558,
      };

      // act
      final result = testAccountInfoModel.toJson();
      // assert
      expect(result, equals(expectedJsonMap));
    });
  });
}
