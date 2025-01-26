class InputUserState {
  final String userName;
  final String profilePicture;

  InputUserState({
    this.userName = '',
    this.profilePicture = '',
  });

  InputUserState copyWith({
    String? userName,
    String? profilePicture,
  }) {
    return InputUserState(
      userName: userName ?? this.userName,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
