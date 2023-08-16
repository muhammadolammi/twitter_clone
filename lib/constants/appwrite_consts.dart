class AppWriteConstants {
  static const String databaseId = '649216575df07e8abc69';
  static const String projectId = '64920c90d233a6b82f8a';
  static const String endPoint = 'https://cloud.appwrite.io/v1';
  static const String userCollectionId = '649957afd8523b30d66d';
  static const String tweetCollectionId = "64dab65e016a22a37bc5";
  static const String imagesBucket = "64db58f65a3bc91bdc3c";

  static String imageUrl(String imageId) =>
      'https://cloud.appwrite.io/v1/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
