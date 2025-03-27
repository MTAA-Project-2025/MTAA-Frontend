import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/services/time_formating_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/full_post_widget.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_state.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:uuid/uuid_value.dart';

class FullPostScreen extends StatefulWidget {
  final PostsRepository repository;
  final String? postId;
  final FullPostResponse? post;

  const FullPostScreen({super.key, required this.repository,
    this.postId, this.post});

  @override
  State<FullPostScreen> createState() => _FullPostScreenScreenState();
}

class _FullPostScreenScreenState extends State<FullPostScreen> {
  late FullPostResponse? post;

  @override
  void initState() {
    if (getIt.isRegistered<BuildContext>()) {
      getIt.unregister<BuildContext>();
    }
    getIt.registerSingleton<BuildContext>(context);

    super.initState();

    context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''));

    Future.microtask(() async {
      final status = await AirplaneModeChecker.instance.checkAirplaneMode();
      if (status == AirplaneModeStatus.on) {
        context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
      }
    });

    AppLifecycleListener(
      onResume: () async {
        Future.microtask(() async {
          if (mounted) {
            final status = await AirplaneModeChecker.instance.checkAirplaneMode();
            if (status == AirplaneModeStatus.off) {
              context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''));
            }
          }
        });
      },
    );

    initialize();
  }

  Future initialize() async {
    if (widget.post != null) {
      post = widget.post!;
    } else {
      var res = await widget.repository.getFullPostById(UuidValue.fromString(widget.postId!));
      if(res!=null){
        post=res;
      }
    }
  }

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
          ],
        ),
        body: BlocBuilder<ExceptionsBloc, ExceptionsState>(builder: (context, state) {
          return Column(children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  if(post==null)
                  Column(
                      children: [
                        const SizedBox(height: 20),
                        DotLoader(),
                      ],
                  ),
                  if(post!=null)
                  FullPostWidget(
                    post: post!,
                    timeFormatingService: getIt<TimeFormatingService>(),
                    isFull: true,
                    repository: widget.repository,
                  ),
                ],
              ),
            ),
          ]);
        }),
        bottomNavigationBar: PhoneBottomMenu(sellectedType: MenuButtons.Home));
  }
}
