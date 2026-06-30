package com.example.teste_flutter_2

import android.content.Intent
import android.net.Uri
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {

    private val CHANNEL = "florida/update"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {

                "installApk" -> {

                    val filePath = call.arguments as String

                    try {

                        val file = File(filePath)

                        if (!file.exists()) {
                            result.error(
                                "FILE_NOT_FOUND",
                                "APK não encontrado.",
                                null
                            )
                            return@setMethodCallHandler
                        }

                        val uri: Uri = FileProvider.getUriForFile(
                            this,
                            "$packageName.fileprovider",
                            file
                        )

                        val intent = Intent(Intent.ACTION_VIEW)

                        intent.setDataAndType(
                            uri,
                            "application/vnd.android.package-archive"
                        )

                        intent.flags =
                            Intent.FLAG_ACTIVITY_NEW_TASK or
                            Intent.FLAG_GRANT_READ_URI_PERMISSION

                        startActivity(intent)

                        result.success(true)

                    } catch (e: Exception) {

                        result.error(
                            "INSTALL_ERROR",
                            e.message,
                            null
                        )
                    }
                }

                else -> result.notImplemented()
            }
        }
    }
}