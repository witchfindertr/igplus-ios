import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class MediaSearch extends StatefulWidget {
  const MediaSearch({
    Key? key,
    this.onChanged,
    this.debounceTime,
    this.searchFocusNode,
  }) : super(key: key);
  final ValueChanged<String>? onChanged;
  final Duration? debounceTime;
  final FocusNode? searchFocusNode;

  @override
  _MediaSearchState createState() => _MediaSearchState();
}

class _MediaSearchState extends State<MediaSearch> {
  final StreamController<String> _textChangeStreamController = StreamController();
  late StreamSubscription _textChangesSubscription;

  @override
  void initState() {
    _textChangesSubscription = _textChangeStreamController.stream
        .debounceTime(
          widget.debounceTime ?? const Duration(seconds: 1),
        )
        .distinct()
        .listen((text) {
      final onChanged = widget.onChanged;
      if (onChanged != null) {
        onChanged(text);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            focusNode: widget.searchFocusNode,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: 'Keyword in your post',
            ),
            onChanged: _textChangeStreamController.add,
          ),
        ),
      );

  @override
  void dispose() {
    _textChangeStreamController.close();
    _textChangesSubscription.cancel();
    super.dispose();
  }
}
