// GENERATED CODE - DO NOT MODIFY BY HAND

part of cart;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Cart> _$cartSerializer = new _$CartSerializer();

class _$CartSerializer implements StructuredSerializer<Cart> {
  @override
  final Iterable<Type> types = const [Cart, _$Cart];
  @override
  final String wireName = 'Cart';

  @override
  Iterable<Object?> serialize(Serializers serializers, Cart object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'product',
      serializers.serialize(object.product,
          specifiedType: const FullType(Product)),
      'quantity',
      serializers.serialize(object.quantity,
          specifiedType: const FullType(int)),
      'price',
      serializers.serialize(object.price,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  Cart deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CartBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'product':
          result.product.replace(serializers.deserialize(value,
              specifiedType: const FullType(Product))! as Product);
          break;
        case 'quantity':
          result.quantity = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$Cart extends Cart {
  @override
  final Product product;
  @override
  final int quantity;
  @override
  final double price;

  factory _$Cart([void Function(CartBuilder)? updates]) =>
      (new CartBuilder()..update(updates)).build();

  _$Cart._({required this.product, required this.quantity, required this.price})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(product, 'Cart', 'product');
    BuiltValueNullFieldError.checkNotNull(quantity, 'Cart', 'quantity');
    BuiltValueNullFieldError.checkNotNull(price, 'Cart', 'price');
  }

  @override
  Cart rebuild(void Function(CartBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CartBuilder toBuilder() => new CartBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Cart &&
        product == other.product &&
        quantity == other.quantity &&
        price == other.price;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, product.hashCode), quantity.hashCode), price.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Cart')
          ..add('product', product)
          ..add('quantity', quantity)
          ..add('price', price))
        .toString();
  }
}

class CartBuilder implements Builder<Cart, CartBuilder> {
  _$Cart? _$v;

  ProductBuilder? _product;
  ProductBuilder get product => _$this._product ??= new ProductBuilder();
  set product(ProductBuilder? product) => _$this._product = product;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  double? _price;
  double? get price => _$this._price;
  set price(double? price) => _$this._price = price;

  CartBuilder();

  CartBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _product = $v.product.toBuilder();
      _quantity = $v.quantity;
      _price = $v.price;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Cart other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Cart;
  }

  @override
  void update(void Function(CartBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Cart build() {
    _$Cart _$result;
    try {
      _$result = _$v ??
          new _$Cart._(
              product: product.build(),
              quantity: BuiltValueNullFieldError.checkNotNull(
                  quantity, 'Cart', 'quantity'),
              price: BuiltValueNullFieldError.checkNotNull(
                  price, 'Cart', 'price'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'product';
        product.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Cart', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
