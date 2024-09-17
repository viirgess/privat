import 'package:flutter/material.dart';
import 'package:privat_test_task/core/di/di.dart';
import 'package:privat_test_task/presentation/cubit/movie/movie_cubit.dart';

import 'package:privat_test_task/presentation/theme/colors.dart';

class InputField extends StatefulWidget {
  final Function(String) onQueryChanged;
  final VoidCallback onFocus;

  const InputField({
    super.key,
    required this.onQueryChanged,
    required this.onFocus,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _movieCubit = getIt<MovieCubit>();

  bool hasInput = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        widget.onFocus();
      }
    });
    _controller.addListener(() {
      setState(() {
        hasInput = _controller.text.isNotEmpty;
        widget.onQueryChanged(_controller.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      onChanged: (query) {
        if (query.length >= 2) {
          _movieCubit.searchMovies(query);
        }
      },
      decoration: InputDecoration(
        hintText: 'Search for a movie...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: hasInput ? Colors.lightBlue : ColorsSource.darkBlue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: hasInput ? ColorsSource.lightBlue : ColorsSource.darkBlue,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: ColorsSource.lightBlue,
            width: 2.0,
          ),
        ),
        suffixIcon: hasInput
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  setState(() {
                    hasInput = false;
                  });
                  _movieCubit.clearSearch();
                },
              )
            : null,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
