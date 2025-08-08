// // // lib/core/types/result.dart
// // sealed class Result<T, E> {
// //   const Result();
// // }

// // class Success<T, E> extends Result<T, E> {
// //   final T value;
// //   const Success(this.value);
// // }

// // class Failure<T, E> extends Result<T, E> {
// //   final E error;
// //   const Failure(this.error);
// // }

// // Storage specific result type
// typedef StorageResult<T> = Result<T, StorageError>;

// enum StorageError {
//   notFound,
//   invalidData,
//   storageFailure,
//   unknown,
// }

// extension StorageErrorMessage on StorageError {
//   String get message {
//     switch (this) {
//       case StorageError.notFound:
//         return 'The requested data was not found';
//       case StorageError.invalidData:
//         return 'The data is invalid or corrupted';
//       case StorageError.storageFailure:
//         return 'Failed to access storage';
//       case StorageError.unknown:
//         return 'An unknown error occurred';
//     }
//   }
// }

// // Audio specific result type
// typedef AudioResult<T> = Result<T, AudioError>;

// enum AudioError {
//   permissionDenied,
//   recordingFailed,
//   playbackFailed,
//   fileNotFound,
//   unknown,
// }

// extension AudioErrorMessage on AudioError {
//   String get message {
//     switch (this) {
//       case AudioError.permissionDenied:
//         return 'Microphone permission is required';
//       case AudioError.recordingFailed:
//         return 'Failed to record audio';
//       case AudioError.playbackFailed:
//         return 'Failed to play audio';
//       case AudioError.fileNotFound:
//         return 'Audio file not found';
//       case AudioError.unknown:
//         return 'An unknown error occurred';
//     }
//   }
// }
