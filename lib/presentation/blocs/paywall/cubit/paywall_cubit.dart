import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'paywall_state.dart';

class PaywallCubit extends Cubit<PaywallState> {
  PaywallCubit() : super(PaywallInitial());
}
