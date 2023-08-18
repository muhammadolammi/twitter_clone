import 'package:appwrite/appwrite.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/constants/appwrite_consts.dart';

final appWriteClientProvider = Provider((ref) {
  Client client = Client();
  return client
      .setEndpoint(AppWriteConstants.endPoint)
      .setProject(AppWriteConstants.projectId)
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
final appwriteStorgaeProvider = Provider((ref) {
  final client = ref.watch(appWriteClientProvider);
  return Storage(client);
});
final appwriteRealtimeProvider = Provider((ref) {
  final client = ref.watch(appWriteClientProvider);
  return Realtime(client);
});
