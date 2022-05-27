import 'package:flutter/material.dart';

import '../models/notification_response_model.dart';
import '../services/notification_service.dart';
import 'dio_controller.dart';

class NotificationController with ChangeNotifier {
  final DioController? _dioController;

  final _notificationService = NotificationService.service;

  NotificationController(
    this._dioController,
  ) {
    getNotifications();
  }

  getNotifications() async {
    if (_isLoading) {
      return;
    }

    if (_dioController == null) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    final model = await _notificationService.getAllNotification(
      dio: _dioController!,
      page: _page,
    );

    if (model?.statusCode != 200) {
      return;
    }

    _notifications
      ..clear()
      ..addAll(model?.data?.data ?? []);
    _isLoading = false;
    notifyListeners();
  }

  int _page = 1;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<NotificationData> _notifications = [];
  List<NotificationData> get notifications => _notifications;
}
