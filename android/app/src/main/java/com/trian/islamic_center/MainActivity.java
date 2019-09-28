package com.trian.islamic_center;

import android.content.Context;
import android.os.Bundle;

import com.google.firebase.FirebaseApp;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  Context context = MainActivity.this;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    FirebaseApp.initializeApp(context);
    GeneratedPluginRegistrant.registerWith(this);
  }
}
