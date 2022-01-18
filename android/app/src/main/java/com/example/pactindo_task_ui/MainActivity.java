package com.example.pactindo_task_ui;

import android.os.Bundle;
// import io.flutter.app.FlutterActivity;
// import io.flutter.app.FlutterFragmentActivity;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

// public class MainActivity extends FlutterActivity {
public class MainActivity extends FlutterFragmentActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
    // @Override
    // protected void onCreate(Bundle savedInstanceState) {
    //   super.onCreate(savedInstanceState);
    //   GeneratedPluginRegistrant.registerWith(this);
    // }
}
