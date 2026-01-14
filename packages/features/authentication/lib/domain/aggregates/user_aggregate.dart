import 'package:shared/domain/aggregate_root.dart';

import '../value_objects/email.dart';
import '../value_objects/user_id.dart';

class UserAggregate extends AggregateRoot<UserId> {
  Email email;
  DateTime createdAt;
  DateTime updatedAt;

  UserAggregate({
    required String id,
    required String email,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now(),
       email = Email(email),
       super(id: UserId(id));
}
