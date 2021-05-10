import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import '../models/product_model.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Product,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
