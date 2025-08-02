// lib/services/notification_service_platform.dart
export 'notification_service_stub.dart'
if (dart.library.io) 'notification_service_mobile.dart'
if (dart.library.html) 'notification_service_stub.dart';
