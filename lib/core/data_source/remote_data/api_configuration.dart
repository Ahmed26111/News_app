 abstract class ApiConfiguration{
   static const String newsBaseUrl = "newsapi.org";
   static const String dummyBaseUrl = "dummyjson.com";
   static const String version = "v2/";
   static const String apiKey = "bf48c06526ec4337bc3bb8fe1867a47b";

   /// Endpoints
   static const String headLineEndPoint = "top-headlines";
   static const String everythingEndPoint = "everything";

   /// dummyEndPoints
   static const String loginEndPoint = "auth/login";
   static const String refreshToken = "auth/refresh";
   static const String currentUser = "auth/me";
 }