import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'engagement_state.dart';

class EngagementCubit extends Cubit<EngagementState> {
  EngagementCubit() : super(EngagementInitial());
}
