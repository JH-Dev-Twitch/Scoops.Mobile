class AppUser {
  String id;
  String username;
  String imageUrl;

  AppUser({this.id, this.imageUrl, this.username});

  AppUser.unauthorizedUser() {
    username = "unknown";
    imageUrl = "";
  }
}
