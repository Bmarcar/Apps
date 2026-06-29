import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_version.dart';
import '../services/update_service.dart';
import '../manegers/update_maneger.dart';

enum UpdateStatus {
  checking,
  available,
  downloading,
  installing,
  completed,
  error,
}

class UpdateState {
  final UpdateStatus status;
  final AppVersion? version;
  final double progress;
  final String? message;

  const UpdateState({
    required this.status,
    this.version,
    this.progress = 0,
    this.message,
  });

  UpdateState copyWith({
    UpdateStatus? status,
    AppVersion? version,
    double? progress,
    String? message,
  }) {
    return UpdateState(
      status: status ?? this.status,
      version: version ?? this.version,
      progress: progress ?? this.progress,
      message: message,
    );
  }
}

class UpdateNotifier extends StateNotifier<UpdateState> {
  UpdateNotifier() : super(const UpdateState(status: UpdateStatus.checking));

  final UpdateService _service = UpdateService();
  final UpdateManager _manager = UpdateManager();

  Future<void> checkUpdate() async {
    try {
      final version = await _service.checkForUpdate();

      if (version == null) {
        state = state.copyWith(status: UpdateStatus.completed);
        return;
      }

      state = state.copyWith(status: UpdateStatus.available, version: version);
    } catch (e) {
      state = state.copyWith(status: UpdateStatus.error, message: e.toString());
    }
  }

  Future<void> downloadUpdate() async {
    try {
      final version = state.version;

      if (version == null) return;

      state = state.copyWith(status: UpdateStatus.downloading, progress: 0);

      final apkPath = await _manager.downloadApk(
        url: version.apkUrl,
        onProgress: (progress) {
          state = state.copyWith(progress: progress);
        },
      );

      state = state.copyWith(status: UpdateStatus.installing);

      await _manager.installApk(apkPath);

      state = state.copyWith(status: UpdateStatus.completed);
    } catch (e) {
      state = state.copyWith(status: UpdateStatus.error, message: e.toString());
    }
  }
}

final updateProvider = StateNotifierProvider<UpdateNotifier, UpdateState>(
  (ref) => UpdateNotifier(),
);
