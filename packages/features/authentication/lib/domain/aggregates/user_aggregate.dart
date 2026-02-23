import 'package:authentication/domain/value_objects/email.dart';
import 'package:authentication/domain/value_objects/user_id.dart';
import 'package:shared/domain/aggregate_root.dart';

class UserAggregate extends AggregateRoot<UserId> {
  UserAggregate({
    required String id,
    required String email,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        email = Email(email),
        super(id: UserId(id));

  Email email;
  DateTime createdAt;
  DateTime updatedAt;
}
