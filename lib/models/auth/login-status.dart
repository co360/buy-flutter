class LoginStatus {
  bool success = false;
  String error;
  bool isGuest = false;

  LoginStatus.success() {
    this.success = true;
    this.isGuest = false;
  }

  LoginStatus.guest() {
    this.success = true;
    this.isGuest = true;
  }

  LoginStatus.error(this.error);
}
