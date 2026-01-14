import 'package:shared/domain/value_object.dart';

class Email extends ValueObject {
  const Email(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}
