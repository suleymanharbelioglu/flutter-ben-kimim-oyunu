
abstract class LoadCachedFamousState {}

// Initial state: nothing loaded yet
class LoadCachedFamousInitial extends LoadCachedFamousState {}

// Loading state: cache is being fetched
class LoadCachedFamousLoading extends LoadCachedFamousState {}

// Success state: cache loaded successfully
class LoadCachedFamousSuccess extends LoadCachedFamousState {}

// Error state: contains error message
class LoadCachedFamousError extends LoadCachedFamousState {
  final String message;
  LoadCachedFamousError(this.message);
}