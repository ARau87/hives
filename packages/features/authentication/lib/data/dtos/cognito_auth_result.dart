/// Data transfer object containing authentication tokens from Cognito.
class CognitoAuthResult {
  const CognitoAuthResult({
    required this.accessToken,
    required this.idToken,
    required this.refreshToken,
    required this.userSub,
  });

  final String accessToken;
  final String idToken;
  final String refreshToken;
  final String userSub;
}
