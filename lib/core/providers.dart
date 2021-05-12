import 'package:provider/provider.dart';
import 'package:supers/core/bloc/cart_bloc.dart';
import 'package:supers/core/bloc/order_bloc.dart';
import 'package:supers/core/bloc/products_bloc.dart';

final providers = [
  ChangeNotifierProvider<ProductsBloc>(
    create: (_) => ProductsBloc(),
  ),
  ChangeNotifierProvider<CartBloc>(
    create: (_) => CartBloc(),
  ),
  ChangeNotifierProvider<OrderBloc>(
    create: (_) => OrderBloc(),
  ),
];
