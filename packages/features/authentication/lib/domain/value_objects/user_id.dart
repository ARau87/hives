import 'package:shared/domain/value_object.dart';

class UserId extends ValueObject {
  const UserId(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}
