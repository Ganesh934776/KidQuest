import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String _userTypeKey = 'userType';
  static const String _parentIdKey = 'parentId';
  static const String _childIdKey = 'childId';

  /// Save Parent Session
  Future<void> saveParentSession(String parentId) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_userTypeKey, 'parent');
    await prefs.setString(_parentIdKey, parentId);
    await prefs.remove(_childIdKey);
  }

  /// Save Child Session
  Future<void> saveChildSession(String childId) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_userTypeKey, 'child');
    await prefs.setString(_childIdKey, childId);
    await prefs.remove(_parentIdKey);
  }

  /// Get User Type
  Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey);
  }

  /// Get Parent Id
  Future<String?> getParentId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_parentIdKey);
  }

  /// Get Child Id
  Future<String?> getChildId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_childIdKey);
  }
    /// Check Login Status
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(_userTypeKey);
  }

  /// Clear Session
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_userTypeKey);
    await prefs.remove(_parentIdKey);
    await prefs.remove(_childIdKey);
  }
}