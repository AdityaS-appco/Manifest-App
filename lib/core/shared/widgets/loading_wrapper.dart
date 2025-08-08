import 'package:manifest/helper/import.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';

class LoadingWrapper extends StatelessWidget {
  /// Indicates if the initial loading is in progress
  final RxBool isInitialLoading;

  /// Indicates if any loading is in progress
  final RxBool isLoading;

  /// Indicates if refreshing is in progress
  final RxBool? isRefreshing;

  /// The main content widget
  final Widget child;

  /// Optional error state
  final RxString? errorMessage;

  /// Callback for retry action
  final VoidCallback? onRetry;

  /// Callback for pull to refresh
  final Future<void> Function()? onRefresh;

  /// Background color for loading state
  final Color? loadingBackgroundColor;

  const LoadingWrapper({
    Key? key,
    required this.isInitialLoading,
    required this.isLoading,
    required this.child,
    this.errorMessage,
    this.onRetry,
    this.onRefresh,
    this.isRefreshing,
    this.loadingBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Initial loading takes precedence
      if (isInitialLoading.value) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Scaffold(
            key: const ValueKey('initial_loading'),
            backgroundColor: loadingBackgroundColor ?? appBackgroundColor,
            body: Center(
              child: dotsWaveLoading(),
            ),
          ),
        );
      }

      // Error state handling
      if (errorMessage != null && errorMessage!.value.isNotEmpty) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Scaffold(
            key: const ValueKey('error_screen'),
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    errorMessage!.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  if (onRetry != null)
                    ElevatedButton(
                      onPressed: onRetry,
                      child: const Text("Retry"),
                    ),
                ],
              ),
            ),
          ),
        );
      }

      // Pull-to-refresh support with optional loading overlay
      Widget content = onRefresh != null
          ? RefreshIndicator(
              onRefresh: () async {
                if (isRefreshing != null) {
                  isRefreshing!.value = true;
                }
                await onRefresh!();
                if (isRefreshing != null) {
                  isRefreshing!.value = false;
                }
              },
              child: child,
            )
          : child;

      // Main content with potential loading overlay
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Stack(
          key: const ValueKey('main_content'),
          fit: StackFit.expand,
          children: [
            Positioned(child: content),
            if (isLoading.value ||
                (isRefreshing != null && isRefreshing!.value))
              Positioned.fill(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: const ValueKey('loading_overlay'),
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: dotsWaveLoading(),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
