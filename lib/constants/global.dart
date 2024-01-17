class Global {
  String _accessToken = '';
  bool isOnline = false;

  // Private constructor for the singleton pattern
  Global._internal();

  // Singleton instance
  static final Global _singleton = Global._internal();

  // Getter for the singleton instance
  static Global get shared => _singleton;

  // Factory constructor to get the singleton instance
  factory Global() {
    return _singleton;
  }

  // Getter for accessToken
  String get accessToken => _accessToken;
  // Setter for accessToken with validation
  set accessToken(String value) {
    // Add validation logic if needed
    _accessToken = value;
  }
  bool get onlineStatus => isOnline;
  set onlineStatus(bool value) {
    isOnline = value;
  }

}
