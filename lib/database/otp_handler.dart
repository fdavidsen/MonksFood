import 'package:monk_food/model/db_manager.dart';
import 'package:monk_food/model/otp_model.dart';
import 'package:sqflite/sqflite.dart';

class OTPHandler {
  final String _tableOTP = DBManager.instance.tableOTP;

  Future<int> insertOTP(OTP otp) async {
    final db = await DBManager.instance.database;
    return await db.insert(
      _tableOTP,
      otp.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<OTP?> getOTP(String email, String otp) async {
    final db = await DBManager.instance.database;
    final result = await db.query(
      _tableOTP,
      where: 'email = ? AND otp = ?',
      whereArgs: [email, otp],
    );

    if (result.isNotEmpty) {
      return OTP.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<void> deleteOTP(int id) async {
    final db = await DBManager.instance.database;
    await db.delete(
      _tableOTP,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
