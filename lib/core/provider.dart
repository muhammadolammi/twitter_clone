import 'package:appwrite/appwrite.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/constants/appwrite_consts.dart';
import 'package:twitter_clone/core/utils.dart';

final appWriteClientProvider = Provider((ref) {
  Client client = Client();
  return client
      .setEndpoint(AppWriteConstant.endPoint)
      .setProject(AppWriteConstant.projectId)
      .setSelfSigned(status: true);
});

final appWriteAccountProvider = Provider((ref) {
  final client = ref.watch(appWriteClientProvider);
  return Account(client);
});

final appwriteDatabaseProvider = Provider((ref) {
  final client = ref.watch(appWriteClientProvider);
  return Databases(client);
});