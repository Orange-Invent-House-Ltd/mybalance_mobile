import 'package:flutter/material.dart';

class AppStartupErrorWidget extends StatefulWidget {
  final Object error;

  final StackTrace stackTrace;

  final Future<void> Function()? retryInitialization;

  const AppStartupErrorWidget({
    required this.error,
    required this.stackTrace,
    this.retryInitialization,
    super.key,
  });

  @override
  State<AppStartupErrorWidget> createState() => _AppStartupErrorWidgetState();
}

class _AppStartupErrorWidgetState extends State<AppStartupErrorWidget> {
  /// Whether the initialization is in progress.
  final _progress = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  Future<void> _retryInitialization() async {
    _progress.value = true;
    await widget.retryInitialization!();
    _progress.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Initialization failed',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  if (widget.retryInitialization != null)
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: _retryInitialization,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '${widget.error}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${widget.stackTrace}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
